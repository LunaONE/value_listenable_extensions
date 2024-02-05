import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

void main() {
  test('map', () {
    final source = ValueNotifier<String>('a');

    final mapped = source.map((value) => value.length);

    expect(mapped.value, 1);

    source.value = 'abc';
    expect(mapped.value, 3);

    mapped.dispose();
    source.value = '';
    // previous value is retained, as connect is severed
    expect(mapped.value, 3);
  });
}
