import 'dart:math';

import 'package:listen/listen.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

void main() {
  // `connect` invokes the callback with the current value and on every change
  final counter = ValueNotifier(1);
  final disconnect = counter.connect((value) => print('counter: $value'));
  // prints "counter: 1"

  counter.value = 2;
  // prints "counter: 2"

  disconnect();

  // `listen` only invokes the callback on changes
  final cancel = counter.listen((value) => print('counter changed: $value'));

  counter.value = 3;
  // prints "counter changed: 3"

  cancel();

  // `map` derives a new value listenable, which is owned by the caller
  final name = ValueNotifier('hello');
  final nameLength = name.map((value) => value.length);
  print(nameLength.value); // 5

  name.value = '';
  print(nameLength.value); // 0

  nameLength.dispose();

  // `combineLatest*` derives a value from multiple value listenables
  final a = ValueNotifier(0);
  final b = ValueNotifier(0);
  final maxValue = combineLatest2(a, b, (a, b) => max(a, b));

  a.value = 5;
  b.value = 3;
  print(maxValue.value); // 5

  maxValue.dispose();

  // `CombinedValueListenable` is the base for state classes built from parts
  final greeting = GreetingState();
  final stopGreeting = greeting.connect(print);
  // prints "Hello"

  greeting.firstName = 'Max';
  // prints "Hello Max"

  greeting.lastName = 'Mustermann';
  // prints "Hello Max Mustermann"

  stopGreeting();
  greeting.dispose();
}

class GreetingState extends CombinedValueListenable<String> {
  GreetingState() {
    // A `connect*` method must be called once in the constructor body
    connect2(_firstName, _lastName, map);
  }

  final _firstName = ValueNotifier('');
  final _lastName = ValueNotifier('');

  set firstName(String value) => _firstName.value = value;

  set lastName(String value) => _lastName.value = value;

  static String map(String firstName, String lastName) {
    return [
      'Hello',
      if (firstName != '') firstName,
      if (lastName != '') lastName,
    ].join(' ');
  }
}
