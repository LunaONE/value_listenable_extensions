import 'package:listen/listen.dart';
import 'package:meta/meta.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

/// A value listenable holding the [AsyncState] of an asynchronous computation.
abstract interface class DisposableAsyncValueListenable<T>
    implements DisposableValueListenable<AsyncState<T>> {
  /// Whether a computation is currently running.
  ///
  /// While it is, [value] keeps the last result, so listeners of [value] are not notified when an update starts.
  /// When a computation completes, this is reset after [value] has been updated, so listeners of [value] still see `true` at that moment.
  ValueListenable<bool> get isUpdating;
}

extension ValueListenableMapAsync<T> on ValueListenable<T> {
  /// Returns a new value listenable which contains the state of the current's value mapped through the asynchronous [map].
  ///
  /// The value is [AsyncLoading] until the first computation completes. Afterwards it keeps the last result while a new computation runs (see [DisposableAsyncValueListenable.isUpdating]).
  /// When the source changes while a computation is running, that computation's result is dropped and only the latest one is exposed.
  ///
  /// The caller of this method gets ownership of the returned value, and must call `dispose` on it if it's no longer needed.
  @useResult
  DisposableAsyncValueListenable<U> mapAsync<U>(
    Future<U> Function(T value) map,
  ) {
    return _MappedAsyncValueListenable(this, map);
  }
}

extension DisposableValueListenableTransformAsync<T>
    on DisposableValueListenable<T> {
  /// Consumes the value listenable, returning a new value listenable which contains the state of the current's value mapped through the asynchronous [map] (see [ValueListenableMapAsync.mapAsync]).
  /// The underlying (passed) value listenable must not be used anymore by the outside code, as it will be disposed with the returned value.
  ///
  /// The caller of this method gets ownership of the returned value, and must call `dispose` on it if it's no longer needed.
  @useResult
  DisposableAsyncValueListenable<U> transformAsync<U>(
    Future<U> Function(T value) map,
  ) {
    return _MappedAsyncValueListenable(this, map, disposeSource: dispose);
  }
}

class _MappedAsyncValueListenable<T, U> extends ValueNotifier<AsyncState<U>>
    implements DisposableAsyncValueListenable<U> {
  _MappedAsyncValueListenable(
    this._source,
    this._map, {
    VoidCallback? disposeSource,
  }) : _disposeSource = disposeSource,
       super(const AsyncLoading()) {
    _source.addListener(_compute);
    _compute();
  }

  final ValueListenable<T> _source;

  final Future<U> Function(T) _map;

  final VoidCallback? _disposeSource;

  final _isUpdating = ValueNotifier(true);

  var _invocation = 0;

  var _isDisposed = false;

  @override
  ValueListenable<bool> get isUpdating => _isUpdating;

  void _compute() {
    final invocation = ++_invocation;
    _isUpdating.value = true;

    Future.sync(() => _map(_source.value)).then(
      (result) => _complete(invocation, AsyncData(result)),
      onError: (Object error, StackTrace stackTrace) {
        final previous = switch (value) {
          AsyncLoading() => null,
          AsyncData<U> data => data,
          AsyncError(:final previous) => previous,
        };

        _complete(
          invocation,
          AsyncError(error, stackTrace, previous: previous),
        );
      },
    );
  }

  void _complete(int invocation, AsyncState<U> state) {
    // the result is outdated, as the source changed (or this was disposed) in the meantime
    if (_isDisposed || invocation != _invocation) {
      return;
    }

    super.value = state;

    // a listener of `value` might have changed the source in the meantime
    if (invocation == _invocation) {
      _isUpdating.value = false;
    }
  }

  @override
  set value(_) => throw Exception('`value` must not be set externally');

  @override
  void dispose() {
    _isDisposed = true;

    _source.removeListener(_compute);
    _disposeSource?.call();
    _isUpdating.dispose();

    super.dispose();
  }
}
