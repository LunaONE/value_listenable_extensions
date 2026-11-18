/// The state of an asynchronous computation, as exposed by `mapAsync` and `transformAsync`.
sealed class AsyncState<T> {
  const AsyncState();
}

/// The computation has not produced a result yet.
final class AsyncLoading<T> extends AsyncState<T> {
  const AsyncLoading();

  @override
  bool operator ==(Object other) => other is AsyncLoading;

  @override
  int get hashCode => (AsyncLoading).hashCode;

  @override
  String toString() => 'AsyncLoading<$T>()';
}

/// The computation completed with [value].
final class AsyncData<T> extends AsyncState<T> {
  const AsyncData(this.value);

  final T value;

  @override
  bool operator ==(Object other) => other is AsyncData && other.value == value;

  @override
  int get hashCode => Object.hash(AsyncData, value);

  @override
  String toString() => 'AsyncData<$T>($value)';
}

/// The computation failed with [error].
final class AsyncError<T> extends AsyncState<T> {
  const AsyncError(this.error, this.stackTrace, {this.previous});

  final Object error;

  final StackTrace stackTrace;

  /// The last data before this error, if there was any.
  ///
  /// This allows showing the error on top of the previously loaded data.
  final AsyncData<T>? previous;

  @override
  bool operator ==(Object other) =>
      other is AsyncError &&
      other.error == error &&
      other.stackTrace == stackTrace &&
      other.previous == previous;

  @override
  int get hashCode => Object.hash(AsyncError, error, stackTrace, previous);

  @override
  String toString() => 'AsyncError<$T>($error, previous: $previous)';
}
