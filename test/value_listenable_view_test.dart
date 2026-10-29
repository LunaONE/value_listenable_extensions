import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

void main() {
  test('ValueListenableView: removeListener after dispose', () {
    final source = ValueNotifier<int>(0);
    final view = ValueListenableView(source);

    var changeCount = 0;
    void listener() => changeCount++;
    view.addListener(listener);

    view.dispose();
    // like on a `ChangeNotifier`, listeners may still unsubscribe after the owner disposed it
    view.removeListener(listener);

    source.value = 1;
    expect(changeCount, 0);
  });

  test('combineLatest: removeListener after dispose', () {
    final combined = combineLatest2(
      ValueNotifier<int>(1),
      ValueNotifier<int>(2),
      (a, b) => a + b,
    );

    final cancel = combined.listen((_) {});

    combined.dispose();

    expect(cancel, returnsNormally);
  });
}
