import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

void main() {
  testWidgets('map: Flutter `ValueNotifier` into `ValueListenableBuilder`', (
    tester,
  ) async {
    final source = ValueNotifier<String>('hello');
    final length = source.map((value) => value.length);
    addTearDown(length.dispose);

    await tester.pumpWidget(_ValueText(length));
    expect(find.text('5'), findsOneWidget);

    source.value = 'hi';
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('combineLatest: Flutter `ValueListenable` subclasses', (
    tester,
  ) async {
    final controller = TextEditingController(text: 'Max');
    addTearDown(controller.dispose);
    final greeting = ValueNotifier<String>('Hello');

    final combined = combineLatest2(
      greeting,
      controller,
      (greeting, name) => '$greeting ${name.text}',
    );
    addTearDown(combined.dispose);

    await tester.pumpWidget(_ValueText(combined));
    expect(find.text('Hello Max'), findsOneWidget);

    controller.text = 'Erika';
    await tester.pump();
    expect(find.text('Hello Erika'), findsOneWidget);
  });

  testWidgets('StaticValueListenable: usable as Flutter `ValueListenable`', (
    tester,
  ) async {
    await tester.pumpWidget(_ValueText(StaticValueListenable('static')));
    expect(find.text('static'), findsOneWidget);
  });

  test('CombinedValueListenable: connects Flutter `ValueNotifier`s', () {
    final greeting = _GreetingState();
    expect(greeting.value, 'Hello');

    greeting.name = 'Max';
    expect(greeting.value, 'Hello Max');

    greeting.dispose();
  });
}

class _ValueText<T> extends StatelessWidget {
  const _ValueText(this.listenable);

  final ValueListenable<T> listenable;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ValueListenableBuilder<T>(
        valueListenable: listenable,
        builder: (context, value, _) => Text('$value'),
      ),
    );
  }
}

class _GreetingState extends CombinedValueListenable<String> {
  _GreetingState() {
    connect1(_name, (name) => name.isEmpty ? 'Hello' : 'Hello $name');
  }

  final _name = ValueNotifier<String>('');

  set name(String value) => _name.value = value;
}
