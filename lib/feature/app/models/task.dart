import 'package:done/feature/app/models/priority.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

part 'task.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String text,
    required bool done,
    required Priority importance,
    int? deadline,
    String? color,
    @JsonKey(name: "created_at") int? createdAt,
    @JsonKey(name: "changed_at") int? changedAt,
    @JsonKey(name: "last_updated_by") String? lastUpdatedBy,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
