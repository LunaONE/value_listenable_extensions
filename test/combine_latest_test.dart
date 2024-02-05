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
}
