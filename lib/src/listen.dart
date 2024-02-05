import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

extension ValueListenableListen<T> on ValueListenable<T> {
  /// Invokes [f] for every future change to the value listenable (ie. will not be invoked with the current value right away).
  ///
  /// Returns a callback to unsubscribe [f] from further updates.
  @useResult
  VoidCallback listen(void Function(T value) f) {
    void onChange() {
      f(value);
    }

    addListener(onChange);

    return () => removeListener(onChange);
  }
}
