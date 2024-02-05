import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

extension ValueListenableMap<T> on ValueListenable<T> {
  /// Returns a new value listenable which contains the current's value mapped through [map].
  ///
  /// The caller of this method gets ownership of the returned value, and must call `dispose` on it if it's no longer needed.
  @useResult
  DisposableValueListenable<U> map<U>(U Function(T value) map) {
    return _MappedValueListenable(this, map);
  }
}

class _MappedValueListenable<T, U> extends ValueNotifier<U>
    implements DisposableValueListenable<U> {
  _MappedValueListenable(
    this._source,
    this._map,
  ) : super(_map(_source.value)) {
    _source.addListener(_onChange);
  }

  final U Function(T) _map;

  final ValueListenable<T> _source;

  void _onChange() {
    super.value = _map(_source.value);
  }

  @override
  set value(_) => throw Exception(
        '`value` must not be set externally',
      );

  @override
  void dispose() {
    _source.removeListener(_onChange);

    super.dispose();
  }
}
