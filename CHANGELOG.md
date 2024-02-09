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
