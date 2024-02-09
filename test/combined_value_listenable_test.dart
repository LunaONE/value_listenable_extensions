import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

void main() {
  test('CombinedValueListener: Single source / map case', () {
    final source = ValueNotifier<String>('hello');

    final listenable = _StringLengthMappingValueListenable(source);

    expect(listenable.value, 5);

    var changeCount = 0;
    listenable.addListener(() {
      changeCount++;
    });

    source.value = '';

    expect(listenable.value, 0);
    expect(changeCount, 1);

    listenable.dispose();
  });

  test('CombinedValueListener: Multi source', () {
    final a = ValueNotifier<int>(0);
    final b = ValueNotifier<int>(1);
    final c = ValueNotifier<int>(2);

    final listenable = _SummingValueListenable(a, b, c);

    expect(listenable.value, 3);

    var changeCount = 0;
    listenable.addListener(() {
      changeCount++;
    });

    b.value = 3;

    expect(listenable.value, 5);
    expect(changeCount, 1);

    c.value = 10;

    expect(listenable.value, 13);
    expect(changeCount, 2);

    listenable.dispose();
  });

  test('CombinedValueListener: Greeting example', () {
    final greeting = _GreetingState();

    expect(greeting.value, 'Hello!');

    greeting.firstName = 'Max';
    expect(greeting.value, 'Hello Max!');

    greeting.lastName = 'Mustermann';
    expect(greeting.value, 'Hello Max Mustermann!');

    greeting.firstName = '';
    expect(greeting.value, 'Hello Mustermann!');

    greeting.dispose();
  });
}

class _StringLengthMappingValueListenable extends CombinedValueListenable<int> {
  _StringLengthMappingValueListenable(ValueNotifier<String> source) {
    connect1(source, (s) => s.length);
  }
}

class _SummingValueListenable extends CombinedValueListenable<int> {
  _SummingValueListenable(
    ValueNotifier<int> a,
    ValueNotifier<int> b,
    ValueNotifier<int> c,
  ) {
    connect3(a, b, c, map);
  }

  static int map(int a, int b, int c) {
    return a + b + c;
  }
}

class _GreetingState extends CombinedValueListenable<String> {
  _GreetingState() {
    connect2(_firstName, _lastName, map);
  }

  final _firstName = ValueNotifier('');
  final _lastName = ValueNotifier('');

  set firstName(String value) => _firstName.value = value;

  set lastName(String value) => _lastName.value = value;

  static String map(String firstName, String lastName) {
    return [
      [
        'Hello',
        if (firstName != '') firstName,
        if (lastName != '') lastName,
      ].join(' '),
      '!',
    ].join();
  }
}
