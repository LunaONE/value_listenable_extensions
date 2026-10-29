import 'package:listen/listen.dart';
import 'package:test/test.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

void main() {
  test('combineLatestAsync', () async {
    final a = ValueNotifier(1);
    final b = ValueNotifier(2);

    final sum = combineLatestAsync2(a, b, (a, b) async => a + b);
    expect(sum.value, const AsyncLoading<int>());

    await pumpEventQueue();
    expect(sum.value, const AsyncData(3));

    b.value = 5;
    expect(sum.isUpdating.value, true);
    await pumpEventQueue();
    expect(sum.value, const AsyncData(6));

    sum.dispose();
  });

  test('combineLatestAsync20 passes all values in order', () async {
    final sources = [for (var i = 1; i <= 20; i++) ValueNotifier(i)];

    final combined = combineLatestAsync20(
      sources[0],
      sources[1],
      sources[2],
      sources[3],
      sources[4],
      sources[5],
      sources[6],
      sources[7],
      sources[8],
      sources[9],
      sources[10],
      sources[11],
      sources[12],
      sources[13],
      sources[14],
      sources[15],
      sources[16],
      sources[17],
      sources[18],
      sources[19],
      (
        v1,
        v2,
        v3,
        v4,
        v5,
        v6,
        v7,
        v8,
        v9,
        v10,
        v11,
        v12,
        v13,
        v14,
        v15,
        v16,
        v17,
        v18,
        v19,
        v20,
      ) async => [
        v1,
        v2,
        v3,
        v4,
        v5,
        v6,
        v7,
        v8,
        v9,
        v10,
        v11,
        v12,
        v13,
        v14,
        v15,
        v16,
        v17,
        v18,
        v19,
        v20,
      ].join(','),
    );
    await pumpEventQueue();
    expect(
      combined.value,
      AsyncData([for (var i = 1; i <= 20; i++) i].join(',')),
    );

    combined.dispose();
  });

  test('combineLatestAsync calls `dispose` on dispose', () async {
    var isDisposed = false;

    final combined = combineLatestAsync2(
      ValueNotifier(1),
      ValueNotifier(2),
      (a, b) async => a + b,
      dispose: () => isDisposed = true,
    );
    expect(isDisposed, false);

    combined.dispose();
    expect(isDisposed, true);
  });
}
