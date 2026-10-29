import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

void main() {
  test('transform', () {
    final source = ValueNotifier<String>('a');

    var sourceDisposed = false;
    final ownedSource = ValueListenableView(
      source,
      dispose: () => sourceDisposed = true,
    );

    final transformed = ownedSource.transform((value) => value.length);

    expect(transformed.value, 1);

    source.value = 'abc';
    expect(transformed.value, 3);

    transformed.dispose();
    // the consumed source is disposed with the transformed value listenable
    expect(sourceDisposed, isTrue);

    source.value = '';
    expect(transformed.value, 3);
  });
}
