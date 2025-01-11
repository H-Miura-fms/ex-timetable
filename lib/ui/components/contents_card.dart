import 'dart:math';
import 'dart:ui';

import 'package:exhibition_timetable/ui/state/minute_state.dart';
import 'package:exhibition_timetable/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/custom_theme.dart';
import '../../domain/session_model.dart';

class ContentsCard extends HookConsumerWidget {
  const ContentsCard({super.key, required this.sessionModel});
  final SessionModel sessionModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// オンタイムかどうか
    final _ = ref.watch(minuteStateProvider);
    bool isOnTime =
        Utils.isOnTime(sessionModel.startTime, sessionModel.endTime);

    /// グラデーションのアニメーション
    final controller = useAnimationController(
      duration: const Duration(seconds: 5),
    )..repeat();
    final animationValue = useAnimation(controller);
    final angle = (isOnTime) ? animationValue * 2 * pi : 4 / pi;

    /// カードの拡大縮小アニメーション
    // final isExpanded = useState(false);
    final heightController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    final curvedAnimation = CurvedAnimation(
      parent: heightController,
      curve: Curves.easeInOut,
    );
    final heightAnimationValue = useAnimation(curvedAnimation);
    defaultHeight() {
      if (sessionModel.category == SessionCategory.rest) {
        return 60.0;
      } else {
        return 140.0;
      }
    }

    final height = lerpDouble(defaultHeight(), 270, heightAnimationValue);
    if (isOnTime && sessionModel.category != SessionCategory.rest) {
      heightController.forward();
    } else {
      heightController.reverse();
    }

    return Stack(
      children: [
        _TimeLineBar(
          startTime: sessionModel.startTime,
          endTime: sessionModel.endTime,
          containerHeight: height!,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            height: height,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ExThemeConfig.color.cardColor,
              border: (isOnTime)
                  ? GradientBoxBorder(
                      gradient: LinearGradient(
                        transform: GradientRotation(angle),
                        colors: [
                          ExThemeConfig.color.graduationStart,
                          ExThemeConfig.color.graduationEnd
                        ],
                      ),
                      width: (isOnTime) ? 4 : 2.5,
                    )
                  : Border.all(
                      color: Colors.grey,
                      width: 2.5,
                    ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Row(
                spacing: 20,
                children: [
                  if (sessionModel.category != SessionCategory.rest)
                    _Period(
                      sessionModel.startTime,
                      sessionModel.endTime,
                    ),
                  Expanded(
                    child: (sessionModel.category == SessionCategory.rest)
                        ? Center(
                            child: Text(
                              "- ${sessionModel.title} -",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            // spacing: 5,
                            children: [
                              Text(
                                sessionModel.title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (sessionModel.category != SessionCategory.rest)
                                Text(
                                  sessionModel.category!.name,
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              if (sessionModel.project != null)
                                Text(
                                  sessionModel.project!,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              if (isOnTime && sessionModel.image != null)
                                Container(
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: ExThemeConfig.color.backGroundColor,
                                    border: Border(),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    spacing: 20,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          sessionModel.description,
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        height: 130,
                                        sessionModel.image!,
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Period extends StatelessWidget {
  const _Period(this.startTime, this.endTime);
  final String startTime;
  final String endTime;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            startTime,
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Text(
              '〜',
            ),
          ),
          Text(
            endTime,
          ),
        ],
      ),
    );
  }
}

class _TimeLineBar extends ConsumerWidget {
  const _TimeLineBar({
    required this.startTime,
    required this.endTime,
    required this.containerHeight,
  });
  final String startTime;
  final String endTime;
  final double containerHeight;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.read(minuteStateProvider);
    bool isOnTime = Utils.isOnTime(startTime, endTime);
    double posY(DateTime now) {
      final period = Utils.calcDuration(startTime, endTime);
      final nowString = Utils.toHHMM(now);
      final duration = Utils.calcDuration(startTime, nowString);
      final y = containerHeight * (duration.inMinutes / period.inMinutes);
      if (y < 0) {
        return 0;
      }
      return y;
    }

    return (isOnTime)
        ? Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: (posY(now) - 20 > 20) ? posY(now) - 20 : 10),
                child: Text(
                  Utils.toHHMM(DateTime.now()),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: posY(now)),
                child: Container(
                  width: double.infinity,
                  height: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          )
        : SizedBox();
  }
}
