import 'package:flutter/foundation.dart';

abstract class DisposableValueListenable<T> implements ValueListenable<T> {
  @mustCallSuper
  void dispose();
}
