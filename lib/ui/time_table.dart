import 'package:exhibition_timetable/core/custom_theme.dart';
import 'package:exhibition_timetable/ui/bubble_area.dart';
import 'package:exhibition_timetable/ui/components/contents_card.dart';
import 'package:exhibition_timetable/ui/components/header_title.dart';
import 'package:exhibition_timetable/ui/state/time_table_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimeTable extends StatelessWidget {
  const TimeTable({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: ExThemeConfig.color.backGroundColor,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  HeaderTitle(),
                  Expanded(
                    child: Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        final sessionModel =
                            ref.watch(timeTableDataNotifierProvider);
                        return sessionModel.when(
                          data: (data) {
                            final data1 = [];
                            final data2 = [];
                            for (var i = 0; i < data.length; i++) {
                              if (i < 8) {
                                data1.add(data[i]);
                              } else {
                                data2.add(data[i]);
                              }
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: ListView.separated(
                                      itemCount: data1.length,
                                      itemBuilder: (context, index) {
                                        return ContentsCard(
                                          sessionModel: data1[index],
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          height: 10,
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      itemCount: data2.length,
                                      itemBuilder: (context, index) {
                                        return ContentsCard(
                                          sessionModel: data2[index],
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          height: 10,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (error, stackTrace) => Center(
                            child: Text('エラーが発生しました'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            BubbleArea(),
            // Image(image: AssetImage('assets/images/logo.gif')),
          ],
        ),
      ),
    );
  }
}
