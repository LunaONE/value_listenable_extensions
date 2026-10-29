import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_listenable_extensions/src/combine_latest.dart';

void main() {
  test('combineLatest', () {
    final a = ValueNotifier<String>('a1');
    final b = ValueNotifier<String>('b1');

    final combined = combineLatest2(a, b, (a, b) => [a, b]);

    expect(combined.value, ['a1', 'b1']);

    a.value = 'a2';
    expect(combined.value, ['a2', 'b1']);

    b.value = 'b2';
    expect(combined.value, ['a2', 'b2']);

    combined.dispose();

    a.value = 'a3'; // works, but does not update combined

    // reading from disposed value listenable is forbidden
    expect(
      () => combined.value,
      throwsA(isA<AssertionError>()
          .having((e) => e.toString(), 'message', contains('Disposed'))),
    );
  });

  test('combineLatest: dispose callback', () {
    var disposeCount = 0;
    final combined = combineLatest2(
      ValueNotifier<int>(1),
      ValueNotifier<int>(2),
      (a, b) => a + b,
      dispose: () => disposeCount++,
    );

    expect(disposeCount, 0);

    combined.dispose();
    expect(disposeCount, 1);
  });

  test('combineLatest: 20 inputs in order', () {
    final n = List.generate(20, (i) => ValueNotifier<int>(i));

    final combined = combineLatest20(
      n[0],
      n[1],
      n[2],
      n[3],
      n[4],
      n[5],
      n[6],
      n[7],
      n[8],
      n[9],
      n[10],
      n[11],
      n[12],
      n[13],
      n[14],
      n[15],
      n[16],
      n[17],
      n[18],
      n[19],
      (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16,
              v17, v18, v19, v20) =>
          [
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
        v20
      ],
    );

    expect(combined.value, List.generate(20, (i) => i));

    n[0].value = 100;
    n[19].value = 119;
    expect(combined.value, [100, ...List.generate(18, (i) => i + 1), 119]);

    combined.dispose();
  });
}
