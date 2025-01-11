import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BubbleArea extends HookWidget {
  const BubbleArea({super.key});

  @override
  Widget build(BuildContext context) {
    // スクリーンサイズを取得
    final screenSize = MediaQuery.of(context).size;

    // 初期位置と速度を管理
    final position =
        useState<Offset>(Offset(screenSize.width / 2, screenSize.height / 2));
    final velocity = useState<Offset>(Offset(0.3, 0.3)); // 直線運動の速度

    // アニメーション用コントローラー
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 16), // 約60fps
    )..repeat();

    // 正弦波の揺れ用パラメータ
    final sineOffset = useState(0.0);
    useEffect(() {
      void listener() {
        // 次の直線的な位置を計算
        final nextPosition = position.value + velocity.value;

        // 壁に当たったら速度を反転
        double newDx = velocity.value.dx;
        double newDy = velocity.value.dy;

        if (nextPosition.dx <= 0 || nextPosition.dx >= screenSize.width - 50) {
          newDx = -velocity.value.dx;
        }
        if (nextPosition.dy <= 0 || nextPosition.dy >= screenSize.height - 50) {
          newDy = -velocity.value.dy;
        }

        // 正弦波によるふわふわの変化量
        sineOffset.value += 0.01;
        final sineDx = sin(sineOffset.value) * 0.5; // 横方向の揺れ
        final sineDy = cos(sineOffset.value) * 0.5; // 縦方向の揺れ

        // 状態を更新
        position.value = Offset(
          (nextPosition.dx + sineDx).clamp(0, screenSize.width - 50),
          (nextPosition.dy + sineDy).clamp(0, screenSize.height - 50),
        );
        velocity.value = Offset(newDx, newDy);
      }

      controller.addListener(listener);

      return () => controller.removeListener(listener);
    }, [controller, screenSize]);

    return Stack(
      children: [
        Positioned(
          left: position.value.dx,
          top: position.value.dy,
          child: Image(
            image: AssetImage('assets/images/logo.gif'),
            width: 80,
          ),
        ),
      ],
    );
  }
}
