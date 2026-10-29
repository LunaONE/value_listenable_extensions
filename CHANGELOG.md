## 2.0.0

* **Breaking:** Depend on [`listen`](https://pub.dev/packages/listen) instead of Flutter
  * The package is now pure Dart and can be used outside of Flutter
  * Flutter re-exports the `listen` types starting with Flutter 3.50, so Flutter apps need Flutter 3.50 or later (stay on 1.x for older versions)
* **Breaking:** Require `disposable_value_listenable` 2.0, which is based on `listen` as well
* **Breaking:** Declare the `CombinedValueListenable.connect*` methods as returning `void` (instead of an implicit `dynamic`)
* Add `mapAsync` and `DisposableValueListenable.transformAsync` to map into a value listenable with an asynchronous computation
  * The value is an `AsyncState` (`AsyncLoading`, `AsyncData`, or `AsyncError` with the `previous` data), the running computation is exposed via `isUpdating`
  * Only the result for the latest source value is exposed
* Require Dart 3.10

## 1.2.1

* Add `DisposableValueListenable.transform` to fully consume and map one value listenable into another
  * When the new one is disposed, the underlying source will be disposed with it
* Allow specifying custom `dispose` callback for `combineLatest*` functions
* Use `DisposableValueListenable` from shared package `disposable_value_listenable`

## 1.2.0

* Add `StaticValueListenable` for when one wants to use a static value with `combineLatest` or in a `CombinedValueListenable`
  * This enables the mapper function to stay clean and not having to use anything besides their given arguments

## 1.1.1

* Expose `CombinedValueListenable`

## 1.1.0

* Add `CombinedValueListenable` to build classes based on the `combineLatest*` logic

## 1.0.1

* Add examples to the README

## 1.0.0

* Add `connect`, `listen`, and `map` extensions for `ValueListenable`
* Add `combineLatest*` helpers to create a new `ValueListenable` from a number of inputs
