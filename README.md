# `ValueListenable` extensions

This package includes a set of useful `ValueListenable` extensions as well as new abstractions to build your own classes with a `ValueListenable` interface.

## Extension methods

### `connect`

Is similar to `addListener`, but handles inline functions by returning a callback to cancel the subscription, thus relieving the caller to use a named function (which would later be used for `removeListener`).

Semantically it differs from `addListener` (and `listen`) in that it invokes the callback right away with the `ValueListenable`'s current `value`.

```dart
final source = ValueNotifier(1);

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
final source = ValueNotifier(1);

final cancel = source.listen((v) => print(v));
// prints nothing

source.value = 2;
// prints 2

cancel();
```

### `mapAsync`

Creates a new `ValueListenable` that derives its value from a source `ValueListenable` mapped by the given asynchronous function.

Its value is an `AsyncState`: `AsyncLoading` until the first computation completes, then `AsyncData` or `AsyncError`. When the source changes, the last result is kept while the new one is computed (signaled by `isUpdating`), and only the result for the latest source value is exposed. An `AsyncError` holds the `previous` data, if there was any, so the error can be shown on top of it.

The caller of `mapAsync` receives ownership of the newly created `ValueListenable` and should later `dispose` it. `transformAsync` does the same, but consumes (and later disposes) its source.

`combineLatestAsync*` is the asynchronous relative of `combineLatest*`, which loads from multiple sources (2 to 20) with the same semantics.

```dart
final userId = ValueNotifier('1');

final profile = userId.mapAsync(loadProfile);

ValueListenableBuilder(
  valueListenable: profile,
  builder: (context, state, _) => switch (state) {
    AsyncLoading() => const Spinner(),
    AsyncData(:final value) => ProfileView(value),
    AsyncError(:final error, previous: AsyncData(:final value)) =>
      Column(children: [ErrorBanner(error), ProfileView(value)]),
    AsyncError(:final error) => ErrorView(error),
  },
);

profile.dispose();
```

## `combineLatest*`

The `combineLatest*` functions provide a `map`-like feature to be used with a number of `ValueListenable` inputs (2 to 20).

The returned output `ValueListenable` will update whenever any of the input changes (and the computed new value differs from the previous, as per the usual `ValueNotifier` comparison).

```dart
final a = ValueNotifier(0);
final b = ValueNotifier(0);

final maxValue = combineLatest2(a, b, (a, b) => max(a, b));
// maxValue.value == 0

a.value = 5;
// maxValue.value == 5

b.value = 3;
// maxValue.value still 5, did recomputed internally but not notify a change to the outside

b.value = 9;
// maxValue.value == 9

maxValue.dispose();
```

The same is available on a record of the inputs, so the arity doesn't have to be spelled out:

```dart
final maxValue = (a, b).combineLatest((a, b) => max(a, b));
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

