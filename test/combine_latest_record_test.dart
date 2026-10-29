import 'package:listen/listen.dart';
import 'package:test/test.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

void main() {
  test('combineLatest on a record', () {
    final count = ValueNotifier(1);
    final name = ValueNotifier('apple');
    final length = name.map((name) => name.length);

    final label = (
      count,
      name,
      length,
    ).combineLatest((count, name, length) => '$count $name ($length)');
    expect(label.value, '1 apple (5)');

    count.value = 2;
    name.value = 'pear';
    expect(label.value, '2 pear (4)');

    label.dispose();
    length.dispose();
  });

  test('combineLatest on a record calls `dispose` on dispose', () {
    var isDisposed = false;

    final combined = (
      ValueNotifier(1),
      ValueNotifier(2),
    ).combineLatest((a, b) => a + b, dispose: () => isDisposed = true);
    expect(combined.value, 3);

    combined.dispose();
    expect(isDisposed, true);
  });

  test('combineLatest on a record of 20 passes all values in order', () {
    final s = [for (var i = 1; i <= 20; i++) ValueNotifier(i)];

    final combined =
        (
          s[0],
          s[1],
          s[2],
          s[3],
          s[4],
          s[5],
          s[6],
          s[7],
          s[8],
          s[9],
          s[10],
          s[11],
          s[12],
          s[13],
          s[14],
          s[15],
          s[16],
          s[17],
          s[18],
          s[19],
        ).combineLatest(
          (
            v1,
            v2,
            v3,
            v4,
            v5,
            v6,
            v7,
            v8,
            v9,
            v10,
            v11,
            v12,
            v13,
            v14,
            v15,
            v16,
            v17,
            v18,
            v19,
            v20,
          ) => [
            v1,
            v2,
            v3,
            v4,
            v5,
            v6,
            v7,
            v8,
            v9,
            v10,
            v11,
            v12,
            v13,
            v14,
            v15,
            v16,
            v17,
            v18,
            v19,
            v20,
          ].join(','),
        );
    expect(combined.value, [for (var i = 1; i <= 20; i++) i].join(','));

    combined.dispose();
  });
}
