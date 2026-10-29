import 'package:test/test.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

void main() {
  test('equality', () {
    final stackTrace = StackTrace.current;

    expect(const AsyncLoading<int>(), const AsyncLoading<int>());
    expect(const AsyncData(1), const AsyncData(1));
    expect(const AsyncData(1), isNot(const AsyncData(2)));
    expect(
      AsyncError<int>('e', stackTrace, previous: const AsyncData(1)),
      AsyncError<int>('e', stackTrace, previous: const AsyncData(1)),
    );
    expect(
      AsyncError<int>('e', stackTrace, previous: const AsyncData(1)),
      isNot(AsyncError<int>('e', stackTrace)),
    );
  });

  test('equality ignores the type argument', () {
    expect(const AsyncData<num>(1), const AsyncData<int>(1));
    expect(const AsyncData<int>(1), const AsyncData<num>(1));
    expect(const AsyncData<String?>('a'), const AsyncData<String>('a'));
    expect(const AsyncLoading<int>(), const AsyncLoading<num>());
  });

  test('distinguishes loaded `null` from no previous data', () {
    final stackTrace = StackTrace.current;

    expect(const AsyncData<int?>(null), isNot(const AsyncLoading<int?>()));
    expect(
      AsyncError<int?>('e', stackTrace, previous: const AsyncData(null)),
      isNot(AsyncError<int?>('e', stackTrace)),
    );
  });
}
