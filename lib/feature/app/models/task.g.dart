// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      id: json['id'] as String,
      text: json['text'] as String,
      done: json['done'] as bool,
      importance: $enumDecode(_$PriorityEnumMap, json['importance']),
      deadline: json['deadline'] as int?,
      color: json['color'] as String?,
      createdAt: json['created_at'] as int?,
      changedAt: json['changed_at'] as int?,
      lastUpdatedBy: json['last_updated_by'] as String?,
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'done': instance.done,
      'importance': _$PriorityEnumMap[instance.importance]!,
      'deadline': instance.deadline,
      'color': instance.color,
      'created_at': instance.createdAt,
      'changed_at': instance.changedAt,
      'last_updated_by': instance.lastUpdatedBy,
    };

const _$PriorityEnumMap = {
  Priority.basic: 'basic',
  Priority.low: 'low',
  Priority.important: 'important',
};
