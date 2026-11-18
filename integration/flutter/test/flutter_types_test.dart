import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

void main() {
  testWidgets('map: Flutter `ValueNotifier` into `ValueListenableBuilder`', (
    tester,
  ) async {
    final source = ValueNotifier<String>('hello');
    final length = source.map((value) => value.length);
    addTearDown(length.dispose);

    await tester.pumpWidget(_ValueText(length));
    expect(find.text('5'), findsOneWidget);

    source.value = 'hi';
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('combineLatest: Flutter `ValueListenable` subclasses', (
    tester,
  ) async {
    final controller = TextEditingController(text: 'Max');
    addTearDown(controller.dispose);
    final greeting = ValueNotifier<String>('Hello');

    final combined = combineLatest2(
      greeting,
      controller,
      (greeting, name) => '$greeting ${name.text}',
    );
    addTearDown(combined.dispose);

    await tester.pumpWidget(_ValueText(combined));
    expect(find.text('Hello Max'), findsOneWidget);

    controller.text = 'Erika';
    await tester.pump();
    expect(find.text('Hello Erika'), findsOneWidget);
  });

  testWidgets('StaticValueListenable: usable as Flutter `ValueListenable`', (
    tester,
  ) async {
    await tester.pumpWidget(_ValueText(StaticValueListenable('static')));
    expect(find.text('static'), findsOneWidget);
  });

  testWidgets('mapAsync: switch over `AsyncState` in a builder', (
    tester,
  ) async {
    final userId = ValueNotifier<int>(1);
    final requests = <int, Completer<String>>{};
    final profile = userId.mapAsync(
      (id) => (requests[id] = Completer()).future,
    );
    addTearDown(profile.dispose);

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: ValueListenableBuilder(
          valueListenable: profile,
          builder: (context, state, _) => switch (state) {
            AsyncLoading() => const Text('loading'),
            AsyncData(:final value) => Text(value),
            AsyncError(previous: AsyncData(:final value)) => Text(
              'failed, showing $value',
            ),
            AsyncError() => const Text('failed'),
          },
        ),
      ),
    );
    expect(find.text('loading'), findsOneWidget);

    requests[1]!.complete('Profile 1');
    await tester.pumpAndSettle();
    expect(find.text('Profile 1'), findsOneWidget);

    userId.value = 2;
    requests[2]!.completeError(Exception('offline'));
    await tester.pumpAndSettle();
    expect(find.text('failed, showing Profile 1'), findsOneWidget);
  });

  test('CombinedValueListenable: connects Flutter `ValueNotifier`s', () {
    final greeting = _GreetingState();
    expect(greeting.value, 'Hello');

    greeting.name = 'Max';
    expect(greeting.value, 'Hello Max');

    greeting.dispose();
  });
}

class _ValueText<T> extends StatelessWidget {
  const _ValueText(this.listenable);

  final ValueListenable<T> listenable;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ValueListenableBuilder<T>(
        valueListenable: listenable,
        builder: (context, value, _) => Text('$value'),
      ),
    );
  }
}

class _GreetingState extends CombinedValueListenable<String> {
  _GreetingState() {
    connect1(_name, (name) => name.isEmpty ? 'Hello' : 'Hello $name');
  }

  final _name = ValueNotifier<String>('');

  set name(String value) => _name.value = value;
}
