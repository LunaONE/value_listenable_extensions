import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

void main() {
  test('connect', () {
    final source = ValueNotifier<String>('initial');

    ({int count, String value})? latestValue;
    final cancel = source.connect((value) {
      latestValue = (count: (latestValue?.count ?? 0) + 1, value: value);
    });

    expect(latestValue, (count: 1, value: 'initial'));

    source.value = 'updated';
    expect(latestValue, (count: 2, value: 'updated'));

    cancel();

    source.value = 'updated again';
    // callback is not invoked again, so test value stays the same as before
    expect(latestValue, (count: 2, value: 'updated'));
  });
}
