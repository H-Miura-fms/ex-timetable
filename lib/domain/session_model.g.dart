// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionModelImpl _$$SessionModelImplFromJson(Map<String, dynamic> json) =>
    _$SessionModelImpl(
      title: json['title'] as String,
      category: const SessionCategoryConverter().fromJson(json['category']),
      project: json['project'] as String?,
      description: json['description'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$SessionModelImplToJson(_$SessionModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'category': _$JsonConverterToJson<dynamic, SessionCategory>(
          instance.category, const SessionCategoryConverter().toJson),
      'project': instance.project,
      'description': instance.description,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'image': instance.image,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
