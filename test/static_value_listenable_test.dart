import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

void main() {
  test('StaticValueListenable', () {
    final greeting = StaticValueListenable('Hello');
    final name = ValueNotifier<String>('Max');

    final combined = combineLatest2(
      greeting,
      name,
      (greeting, name) => '$greeting $name',
    );

    expect(combined.value, 'Hello Max');

    name.value = 'Erika';
    expect(combined.value, 'Hello Erika');

    combined.dispose();
  });
}
