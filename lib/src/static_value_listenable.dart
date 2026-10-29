import 'package:listen/listen.dart';

class StaticValueListenable<T> implements ValueListenable<T> {
  StaticValueListenable(this.value);

  @override
  final T value;

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}
}
