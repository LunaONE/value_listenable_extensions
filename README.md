# `ValueListenable` extensions

This package includes a set of useful `ValueListenable` extensions as well as new abstractions to build your own classes with a `ValueListenable` interface.

## Extension methods

### `connect`

Is similar to `addListener`, but handles inline functions by returning a callback to cancel the subscription, thus relieving the caller to use a named function (which would later be used for `removeListener`).

Semantically it differs from `addListener` (and `listen`) in that it invokes the callback right away with the `ValueListenable`'s current `value`.

```dart
final source = ValueListenable(1);

final cancel = source.connect((v) => print(v));
// prints 1

source.value = 2;
// prints 2

cancel();
```

### `map`

Creates a new `ValueListenable` that derives its value from a source `ValueListenable` mapped by the given function.

The caller of `map` receives ownership of the newly created `ValueListenable` and should later `dispose` it.

```dart
final source = ValueNotifier('hello');

final mapped = source.map((v) => v.length);
// mapped.value == 5

source.value = '';
// mapped.value == 0

mapped.dispose();
```

### `listen`

Is a variant of `addListener` which returns a callback to unsubscribe and is thus useful for inline functions.

Like `addListener` it will be invoked for every subsequent change (but not the initial value).


```dart
final source = ValueListenable(1);

final cancel = source.listen((v) => print(v));
// prints nothing

source.value = 2;
// prints 2

cancel();
```

## `combineLatest*`

The `combineLatest*` functions provide a `map`-like feature to be used with a number of `ValueListenable` inputs (2 to 20).

The returned output `ValueListenable` will update whenever any of the input changes (and the computed new value differs from the previous, as per the usual `ValueNotifier` comparison).

```dart
final a = ValueNotifier(0);
final b = ValueNotifier(0);

final maxValue = combineLatest(a, b, (a, b) => max(a, b));
// maxValue.value == 0

a.value = 5;
// maxValue.value == 5

b.value = 3;
// maxValue.value still 5, did recomputed internally but not notify a change to the outside

b.value = 9;
// maxValue.value == 9

maxValue.dispose();
```

## `CombinedValueListenable`

The `class`-based relative of `combineLatest*` is useful to build state objects which are made up of small, independent parts or that depend on external inputs in addition to their internal state.

Rebuilding the output state from the ground up has many benefits: Unlike using `copyWith` on the previous state, one can't forget to update dependent fields, and the mapping/combination logic can be tested in isolation (if it's a free function or static method (which is recommended to not inadvertently depend on any other instance state)).

```dart
class _GreetingState extends CombinedValueListenable<String> {
  _GreetingState() {
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
```

