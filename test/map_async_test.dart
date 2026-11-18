import 'dart:async';

import 'package:listen/listen.dart';
import 'package:test/test.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

void main() {
  test('loads the initial value', () async {
    final source = ValueNotifier('a');
    final completer = Completer<int>();

    final mapped = source.mapAsync((_) => completer.future);
    expect(mapped.value, const AsyncLoading<int>());
    expect(mapped.isUpdating.value, true);

    completer.complete(1);
    await pumpEventQueue();
    expect(mapped.value, const AsyncData(1));
    expect(mapped.isUpdating.value, false);

    mapped.dispose();
  });

  test('keeps the last data while updating', () async {
    final source = ValueNotifier('a');
    final completers = <String, Completer<int>>{};

    final mapped = source.mapAsync(
      (value) => (completers[value] = Completer()).future,
    );
    completers['a']!.complete(1);
    await pumpEventQueue();

    var notifications = 0;
    mapped.addListener(() => notifications++);

    source.value = 'ab';
    expect(mapped.value, const AsyncData(1));
    expect(mapped.isUpdating.value, true);
    expect(notifications, 0);

    completers['ab']!.complete(2);
    await pumpEventQueue();
    expect(mapped.value, const AsyncData(2));
    expect(mapped.isUpdating.value, false);
    expect(notifications, 1);

    mapped.dispose();
  });

  test('only exposes the result of the latest source value', () async {
    final source = ValueNotifier('a');
    final completers = <String, Completer<int>>{};

    final mapped = source.mapAsync(
      (value) => (completers[value] = Completer()).future,
    );

    source.value = 'b';
    completers['b']!.complete(2);
    await pumpEventQueue();
    expect(mapped.value, const AsyncData(2));

    // the outdated computation completes last
    completers['a']!.complete(1);
    await pumpEventQueue();
    expect(mapped.value, const AsyncData(2));

    source.value = 'c';
    completers['c']!.complete(3);
    source.value = 'd';
    await pumpEventQueue();
    // the completed computation for 'c' is outdated, as 'd' is still pending
    expect(mapped.value, const AsyncData(2));
    expect(mapped.isUpdating.value, true);

    mapped.dispose();
  });

  test(
    'keeps updating when a listener changes the source on a result',
    () async {
      final source = ValueNotifier('a');
      final completers = <String, Completer<int>>{};

      final mapped = source.mapAsync(
        (value) => (completers[value] = Completer()).future,
      );
      mapped.addListener(() => source.value = 'b');

      completers['a']!.complete(1);
      await pumpEventQueue();
      expect(mapped.value, const AsyncData(1));
      expect(mapped.isUpdating.value, true);

      completers['b']!.complete(2);
      await pumpEventQueue();
      expect(mapped.value, const AsyncData(2));
      expect(mapped.isUpdating.value, false);

      mapped.dispose();
    },
  );

  test('does not notify for equal results', () async {
    final source = ValueNotifier('a');

    final mapped = source.mapAsync((value) async => value.length);
    await pumpEventQueue();

    var notifications = 0;
    mapped.addListener(() => notifications++);

    source.value = 'b';
    await pumpEventQueue();
    expect(mapped.value, const AsyncData(1));
    expect(notifications, 0);

    mapped.dispose();
  });

  test('exposes errors without previous data', () async {
    final source = ValueNotifier('a');

    final mapped = source.mapAsync<int>((_) async => throw Exception('a'));
    await pumpEventQueue();

    expect(
      mapped.value,
      isA<AsyncError<int>>()
          .having((s) => s.error, 'error', isA<Exception>())
          .having((s) => s.previous, 'previous', isNull),
    );
    expect(mapped.isUpdating.value, false);

    mapped.dispose();
  });

  test('exposes errors thrown synchronously', () async {
    final source = ValueNotifier('a');

    final mapped = source.mapAsync<int>((_) => throw Exception('a'));
    await pumpEventQueue();

    expect(mapped.value, isA<AsyncError<int>>());

    mapped.dispose();
  });

  test('keeps the previous data on errors', () async {
    final source = ValueNotifier(1);

    final mapped = source.mapAsync((value) async {
      if (value < 0) {
        throw Exception('$value');
      }

      return value;
    });
    await pumpEventQueue();

    source.value = -1;
    await pumpEventQueue();
    expect(
      mapped.value,
      isA<AsyncError<int>>()
          .having((s) => '${s.error}', 'error', 'Exception: -1')
          .having((s) => s.previous, 'previous', const AsyncData(1)),
    );

    // a subsequent error still refers to the last data
    source.value = -2;
    await pumpEventQueue();
    expect(
      mapped.value,
      isA<AsyncError<int>>()
          .having((s) => '${s.error}', 'error', 'Exception: -2')
          .having((s) => s.previous, 'previous', const AsyncData(1)),
    );

    source.value = 2;
    await pumpEventQueue();
    expect(mapped.value, const AsyncData(2));

    mapped.dispose();
  });

  test('ignores results completing after `dispose`', () async {
    final source = ValueNotifier('a');
    final completer = Completer<int>();

    final mapped = source.mapAsync((_) => completer.future);
    mapped.dispose();

    completer.complete(1);
    await pumpEventQueue();
  });

  test('ignores errors completing after `dispose`', () async {
    final source = ValueNotifier('a');
    final completer = Completer<int>();

    final mapped = source.mapAsync((_) => completer.future);
    mapped.dispose();

    completer.completeError(Exception('a'));
    await pumpEventQueue();
  });

  test('stops mapping the source after `dispose`', () async {
    final source = ValueNotifier('a');
    final values = <String>[];

    final mapped = source.mapAsync((value) async {
      values.add(value);

      return value.length;
    });
    mapped.dispose();

    source.value = 'b';
    await pumpEventQueue();
    expect(values, ['a']);
  });

  test('transformAsync disposes the source', () async {
    final source = ValueNotifier('a');
    var isSourceDisposed = false;

    final transformed = ValueListenableView(
      source,
      dispose: () => isSourceDisposed = true,
    ).transformAsync((value) async => value.length);
    await pumpEventQueue();
    expect(transformed.value, const AsyncData(1));

    source.value = 'ab';
    await pumpEventQueue();
    expect(transformed.value, const AsyncData(2));

    transformed.dispose();
    expect(isSourceDisposed, true);
  });

  test('combines multiple sources', () async {
    final a = ValueNotifier(1);
    final b = ValueNotifier(2);

    final sum = combineLatest2(
      a,
      b,
      (a, b) => (a, b),
    ).transformAsync((v) async => v.$1 + v.$2);
    await pumpEventQueue();
    expect(sum.value, const AsyncData(3));

    b.value = 5;
    await pumpEventQueue();
    expect(sum.value, const AsyncData(6));

    sum.dispose();
  });
}
