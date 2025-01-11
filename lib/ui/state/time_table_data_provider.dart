import 'package:exhibition_timetable/domain/session_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../service/file_service.dart';

part 'time_table_data_provider.g.dart';

@riverpod
class TimeTableDataNotifier extends _$TimeTableDataNotifier {
  @override
  FutureOr<List<SessionModel>> build() {
    return _fetch();
  }

  Future<List<SessionModel>> _fetch() async {
    final service = ref.read(fileServiceProvider);
    try {
      final json = await service.loadJson();
      final List<dynamic> data = json['contents'];
      final List<SessionModel> sessionModelList =
          data.map((e) => SessionModel.fromJson(e)).toList();
      return sessionModelList;
    } catch (e) {
      print(e);
      throw Exception('Failed to load json');
    }
  }
}
