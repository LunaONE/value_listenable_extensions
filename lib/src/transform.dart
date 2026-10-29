import 'package:listen/listen.dart';
import 'package:meta/meta.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

extension DisposableValueListenableTransform<T>
    on DisposableValueListenable<T> {
  /// Cosumes the value listenable, returning a new value listenable which contains the current's value mapped through [map].
  /// The underlying (passed) value listenable must not be used anymore by the outside code, as it will be disposed with the returned value.
  ///
  /// The caller of this method gets ownership of the returned value, and must call `dispose` on it if it's no longer needed.
  @useResult
  DisposableValueListenable<U> transform<U>(U Function(T value) map) {
    return _TransformedValueListenable(this, map);
  }
}

class _TransformedValueListenable<T, U> extends ValueNotifier<U>
    implements DisposableValueListenable<U> {
  _TransformedValueListenable(
    this._source,
    this._map,
  ) : super(_map(_source.value)) {
    _source.addListener(_onChange);
  }

  final U Function(T) _map;

  final DisposableValueListenable<T> _source;

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
    _source.dispose();

    super.dispose();
  }
}
