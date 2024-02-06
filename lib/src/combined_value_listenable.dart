// Generated by `./generate_code.sh`
//
// DO NOT EDIT MANUALLY
//

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:value_listenable_extensions/value_listenable_extensions.dart';

abstract class CombinedValueListenable<T>
    implements DisposableValueListenable<T> {
  CombinedValueListenable() {
    scheduleMicrotask(() {
      assert(
        // ignore: unnecessary_type_check
        _source is Object,
        'connect*() has been invoked and a source has been set',
      );
    });
  }

  late final DisposableValueListenable<T> _source;

  @protected
  connect1<T1>(
    ValueListenable<T1> vl1,
    T Function(
      T1 v1,
    ) map,
  ) {
    _source = vl1.map(map);
  }

  @protected
  connect2<T1, T2>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    T Function(
      T1 v1,
      T2 v2,
    ) map,
  ) {
    _source = combineLatest2(
      vl1,
      vl2,
      map,
    );
  }

  @protected
  connect3<T1, T2, T3>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
    ) map,
  ) {
    _source = combineLatest3(
      vl1,
      vl2,
      vl3,
      map,
    );
  }

  @protected
  connect4<T1, T2, T3, T4>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
    ) map,
  ) {
    _source = combineLatest4(
      vl1,
      vl2,
      vl3,
      vl4,
      map,
    );
  }

  @protected
  connect5<T1, T2, T3, T4, T5>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
    ) map,
  ) {
    _source = combineLatest5(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      map,
    );
  }

  @protected
  connect6<T1, T2, T3, T4, T5, T6>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
    ) map,
  ) {
    _source = combineLatest6(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      map,
    );
  }

  @protected
  connect7<T1, T2, T3, T4, T5, T6, T7>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    ValueListenable<T7> vl7,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
      T7 v7,
    ) map,
  ) {
    _source = combineLatest7(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      vl7,
      map,
    );
  }

  @protected
  connect8<T1, T2, T3, T4, T5, T6, T7, T8>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    ValueListenable<T7> vl7,
    ValueListenable<T8> vl8,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
      T7 v7,
      T8 v8,
    ) map,
  ) {
    _source = combineLatest8(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      vl7,
      vl8,
      map,
    );
  }

  @protected
  connect9<T1, T2, T3, T4, T5, T6, T7, T8, T9>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    ValueListenable<T7> vl7,
    ValueListenable<T8> vl8,
    ValueListenable<T9> vl9,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
      T7 v7,
      T8 v8,
      T9 v9,
    ) map,
  ) {
    _source = combineLatest9(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      vl7,
      vl8,
      vl9,
      map,
    );
  }

  @protected
  connect10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    ValueListenable<T7> vl7,
    ValueListenable<T8> vl8,
    ValueListenable<T9> vl9,
    ValueListenable<T10> vl10,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
      T7 v7,
      T8 v8,
      T9 v9,
      T10 v10,
    ) map,
  ) {
    _source = combineLatest10(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      vl7,
      vl8,
      vl9,
      vl10,
      map,
    );
  }

  @protected
  connect11<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    ValueListenable<T7> vl7,
    ValueListenable<T8> vl8,
    ValueListenable<T9> vl9,
    ValueListenable<T10> vl10,
    ValueListenable<T11> vl11,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
      T7 v7,
      T8 v8,
      T9 v9,
      T10 v10,
      T11 v11,
    ) map,
  ) {
    _source = combineLatest11(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      vl7,
      vl8,
      vl9,
      vl10,
      vl11,
      map,
    );
  }

  @protected
  connect12<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    ValueListenable<T7> vl7,
    ValueListenable<T8> vl8,
    ValueListenable<T9> vl9,
    ValueListenable<T10> vl10,
    ValueListenable<T11> vl11,
    ValueListenable<T12> vl12,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
      T7 v7,
      T8 v8,
      T9 v9,
      T10 v10,
      T11 v11,
      T12 v12,
    ) map,
  ) {
    _source = combineLatest12(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      vl7,
      vl8,
      vl9,
      vl10,
      vl11,
      vl12,
      map,
    );
  }

  @protected
  connect13<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    ValueListenable<T7> vl7,
    ValueListenable<T8> vl8,
    ValueListenable<T9> vl9,
    ValueListenable<T10> vl10,
    ValueListenable<T11> vl11,
    ValueListenable<T12> vl12,
    ValueListenable<T13> vl13,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
      T7 v7,
      T8 v8,
      T9 v9,
      T10 v10,
      T11 v11,
      T12 v12,
      T13 v13,
    ) map,
  ) {
    _source = combineLatest13(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      vl7,
      vl8,
      vl9,
      vl10,
      vl11,
      vl12,
      vl13,
      map,
    );
  }

  @protected
  connect14<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    ValueListenable<T7> vl7,
    ValueListenable<T8> vl8,
    ValueListenable<T9> vl9,
    ValueListenable<T10> vl10,
    ValueListenable<T11> vl11,
    ValueListenable<T12> vl12,
    ValueListenable<T13> vl13,
    ValueListenable<T14> vl14,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
      T7 v7,
      T8 v8,
      T9 v9,
      T10 v10,
      T11 v11,
      T12 v12,
      T13 v13,
      T14 v14,
    ) map,
  ) {
    _source = combineLatest14(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      vl7,
      vl8,
      vl9,
      vl10,
      vl11,
      vl12,
      vl13,
      vl14,
      map,
    );
  }

  @protected
  connect15<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    ValueListenable<T7> vl7,
    ValueListenable<T8> vl8,
    ValueListenable<T9> vl9,
    ValueListenable<T10> vl10,
    ValueListenable<T11> vl11,
    ValueListenable<T12> vl12,
    ValueListenable<T13> vl13,
    ValueListenable<T14> vl14,
    ValueListenable<T15> vl15,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
      T7 v7,
      T8 v8,
      T9 v9,
      T10 v10,
      T11 v11,
      T12 v12,
      T13 v13,
      T14 v14,
      T15 v15,
    ) map,
  ) {
    _source = combineLatest15(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      vl7,
      vl8,
      vl9,
      vl10,
      vl11,
      vl12,
      vl13,
      vl14,
      vl15,
      map,
    );
  }

  @protected
  connect16<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15,
      T16>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    ValueListenable<T7> vl7,
    ValueListenable<T8> vl8,
    ValueListenable<T9> vl9,
    ValueListenable<T10> vl10,
    ValueListenable<T11> vl11,
    ValueListenable<T12> vl12,
    ValueListenable<T13> vl13,
    ValueListenable<T14> vl14,
    ValueListenable<T15> vl15,
    ValueListenable<T16> vl16,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
      T7 v7,
      T8 v8,
      T9 v9,
      T10 v10,
      T11 v11,
      T12 v12,
      T13 v13,
      T14 v14,
      T15 v15,
      T16 v16,
    ) map,
  ) {
    _source = combineLatest16(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      vl7,
      vl8,
      vl9,
      vl10,
      vl11,
      vl12,
      vl13,
      vl14,
      vl15,
      vl16,
      map,
    );
  }

  @protected
  connect17<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15,
      T16, T17>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    ValueListenable<T7> vl7,
    ValueListenable<T8> vl8,
    ValueListenable<T9> vl9,
    ValueListenable<T10> vl10,
    ValueListenable<T11> vl11,
    ValueListenable<T12> vl12,
    ValueListenable<T13> vl13,
    ValueListenable<T14> vl14,
    ValueListenable<T15> vl15,
    ValueListenable<T16> vl16,
    ValueListenable<T17> vl17,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
      T7 v7,
      T8 v8,
      T9 v9,
      T10 v10,
      T11 v11,
      T12 v12,
      T13 v13,
      T14 v14,
      T15 v15,
      T16 v16,
      T17 v17,
    ) map,
  ) {
    _source = combineLatest17(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      vl7,
      vl8,
      vl9,
      vl10,
      vl11,
      vl12,
      vl13,
      vl14,
      vl15,
      vl16,
      vl17,
      map,
    );
  }

  @protected
  connect18<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15,
      T16, T17, T18>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    ValueListenable<T7> vl7,
    ValueListenable<T8> vl8,
    ValueListenable<T9> vl9,
    ValueListenable<T10> vl10,
    ValueListenable<T11> vl11,
    ValueListenable<T12> vl12,
    ValueListenable<T13> vl13,
    ValueListenable<T14> vl14,
    ValueListenable<T15> vl15,
    ValueListenable<T16> vl16,
    ValueListenable<T17> vl17,
    ValueListenable<T18> vl18,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
      T7 v7,
      T8 v8,
      T9 v9,
      T10 v10,
      T11 v11,
      T12 v12,
      T13 v13,
      T14 v14,
      T15 v15,
      T16 v16,
      T17 v17,
      T18 v18,
    ) map,
  ) {
    _source = combineLatest18(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      vl7,
      vl8,
      vl9,
      vl10,
      vl11,
      vl12,
      vl13,
      vl14,
      vl15,
      vl16,
      vl17,
      vl18,
      map,
    );
  }

  @protected
  connect19<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15,
      T16, T17, T18, T19>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    ValueListenable<T7> vl7,
    ValueListenable<T8> vl8,
    ValueListenable<T9> vl9,
    ValueListenable<T10> vl10,
    ValueListenable<T11> vl11,
    ValueListenable<T12> vl12,
    ValueListenable<T13> vl13,
    ValueListenable<T14> vl14,
    ValueListenable<T15> vl15,
    ValueListenable<T16> vl16,
    ValueListenable<T17> vl17,
    ValueListenable<T18> vl18,
    ValueListenable<T19> vl19,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
      T7 v7,
      T8 v8,
      T9 v9,
      T10 v10,
      T11 v11,
      T12 v12,
      T13 v13,
      T14 v14,
      T15 v15,
      T16 v16,
      T17 v17,
      T18 v18,
      T19 v19,
    ) map,
  ) {
    _source = combineLatest19(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      vl7,
      vl8,
      vl9,
      vl10,
      vl11,
      vl12,
      vl13,
      vl14,
      vl15,
      vl16,
      vl17,
      vl18,
      vl19,
      map,
    );
  }

  @protected
  connect20<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15,
      T16, T17, T18, T19, T20>(
    ValueListenable<T1> vl1,
    ValueListenable<T2> vl2,
    ValueListenable<T3> vl3,
    ValueListenable<T4> vl4,
    ValueListenable<T5> vl5,
    ValueListenable<T6> vl6,
    ValueListenable<T7> vl7,
    ValueListenable<T8> vl8,
    ValueListenable<T9> vl9,
    ValueListenable<T10> vl10,
    ValueListenable<T11> vl11,
    ValueListenable<T12> vl12,
    ValueListenable<T13> vl13,
    ValueListenable<T14> vl14,
    ValueListenable<T15> vl15,
    ValueListenable<T16> vl16,
    ValueListenable<T17> vl17,
    ValueListenable<T18> vl18,
    ValueListenable<T19> vl19,
    ValueListenable<T20> vl20,
    T Function(
      T1 v1,
      T2 v2,
      T3 v3,
      T4 v4,
      T5 v5,
      T6 v6,
      T7 v7,
      T8 v8,
      T9 v9,
      T10 v10,
      T11 v11,
      T12 v12,
      T13 v13,
      T14 v14,
      T15 v15,
      T16 v16,
      T17 v17,
      T18 v18,
      T19 v19,
      T20 v20,
    ) map,
  ) {
    _source = combineLatest20(
      vl1,
      vl2,
      vl3,
      vl4,
      vl5,
      vl6,
      vl7,
      vl8,
      vl9,
      vl10,
      vl11,
      vl12,
      vl13,
      vl14,
      vl15,
      vl16,
      vl17,
      vl18,
      vl19,
      vl20,
      map,
    );
  }

  @override
  void addListener(VoidCallback listener) {
    _source.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _source.removeListener(listener);
  }

  @override
  T get value => _source.value;

  @override
  void dispose() {
    _source.dispose();
  }
}