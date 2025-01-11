import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'minute_state.g.dart';

@riverpod
class MinuteState extends _$MinuteState {
  Timer? timer;

  @override
  DateTime build() {
    // 初期値として現在時刻を設定
    _startMinuteTimer();
    return DateTime.now();
  }

  void _startMinuteTimer() {
    final now = DateTime.now();
    final nextMinute =
        DateTime(now.year, now.month, now.day, now.hour, now.minute + 1);
    final duration = nextMinute.difference(now);

    timer = Timer(duration, () {
      state = DateTime.now();
      _startMinuteTimer(); // 再度タイマーを設定
    });
  }
}
