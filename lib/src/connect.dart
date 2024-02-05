import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

extension ValueListenableConnect<T> on ValueListenable<T> {
  /// Connects [f] to the the value listenable, invoking it immediately for the initial value and then on every subsequent update.
  ///
  /// Returns a callback to unsubscribe [f] from further updates.
  @useResult
  VoidCallback connect(void Function(T value) f) {
    void onChange() {
      f(value);
    }

    onChange();
    addListener(onChange);

    return () => removeListener(onChange);
  }
}
