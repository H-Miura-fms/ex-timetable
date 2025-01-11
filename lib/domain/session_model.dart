import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_model.freezed.dart';
part 'session_model.g.dart';

@freezed
class SessionModel with _$SessionModel {
  const factory SessionModel({
    required String title,
    @SessionCategoryConverter() required SessionCategory? category,
    String? project,
    required String description,
    required String startTime,
    required String endTime,
    String? image,
  }) = _SessionModel;
  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);
}

enum SessionCategory {
  specialGuestTalk,
  lightningTalk,
  demonstration,
  workShop,
  rest;

  String get name {
    switch (this) {
      case SessionCategory.specialGuestTalk:
        return 'Special Guest Talk';
      case SessionCategory.lightningTalk:
        return 'Lightning Talk / Research';
      case SessionCategory.demonstration:
        return 'Interactive Demonstration / Meet-Up';
      case SessionCategory.workShop:
        return 'Exclusive Workshop';
      case SessionCategory.rest:
        return '休憩';
    }
  }
}

class SessionCategoryConverter
    implements JsonConverter<SessionCategory, dynamic> {
  const SessionCategoryConverter();

  @override
  SessionCategory fromJson(dynamic json) {
    switch (json) {
      case 0:
        return SessionCategory.specialGuestTalk;
      case 1:
        return SessionCategory.lightningTalk;
      case 2:
        return SessionCategory.demonstration;
      case 3:
        return SessionCategory.workShop;
      case 4:
        return SessionCategory.rest;
      default:
        throw Exception('Unknown value: $json');
    }
  }

  @override
  dynamic toJson(SessionCategory object) => object.index;
}
