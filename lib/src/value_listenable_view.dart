import 'package:flutter/foundation.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

/// A "read only" view into a value listenable, which allows specifying a `dispose` behavior, thus making it confirm to `DisposableValueListenable`
class ValueListenableView<T> implements DisposableValueListenable<T> {
  ValueListenableView(
    ValueListenable<T> notifier, {
    /// If this object should represent the sole access to the underlying [notifier],
    /// then [dipose] should contain a call to the notifier's disposal
    VoidCallback? dispose,
  })  : _notifier = notifier,
        _dispose = dispose;

  final ValueListenable<T> _notifier;

  final VoidCallback? _dispose;

  bool _isDisposed = false;

  @override
  T get value {
    assert(!_isDisposed);

    return _notifier.value;
  }

  @override
  void addListener(void Function() listener) {
    assert(!_isDisposed);

    _notifier.addListener(listener);
  }

  @override
  void removeListener(void Function() listener) {
    assert(!_isDisposed);

    _notifier.removeListener(listener);
  }

  @override
  void dispose() {
    assert(!_isDisposed);
    _isDisposed = true;

    _dispose?.call();
  }
}
