import 'package:exhibition_timetable/ui/components/gradation_text.dart';
import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // _Title(),
        Image(
          image: AssetImage('assets/images/main_visual.png'),
          height: 80,
        ),
        SizedBox(height: 10),
        // Text(
        //   "- Timetable -",
        //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        // ),
        // SizedBox(height: 10),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradationText(text: '第4回 渡邊恵太研究室 プロトタイプ展'),
        GradationText(text: '超軽工業へ', fontSize: 35, fontWeight: FontWeight.bold),
        GradationText(text: "インタラクションデザインを超えて", fontSize: 20),
        SizedBox(height: 10),
        Text(
          "- Timetable -",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
