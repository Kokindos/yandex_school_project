// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'task_edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaskEditState {
  TextEditingController get textController =>
      throw _privateConstructorUsedError;
  Priority get importance => throw _privateConstructorUsedError;
  int? get deadline => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TextEditingController textController,
            Priority importance, int? deadline)
        task,
    required TResult Function(
            Task editingTask,
            TextEditingController textController,
            Priority importance,
            int? deadline)
        editingTask,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TextEditingController textController, Priority importance,
            int? deadline)?
        task,
    TResult Function(Task editingTask, TextEditingController textController,
            Priority importance, int? deadline)?
        editingTask,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TextEditingController textController, Priority importance,
            int? deadline)?
        task,
    TResult Function(Task editingTask, TextEditingController textController,
            Priority importance, int? deadline)?
        editingTask,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskEditStateInitial value) task,
    required TResult Function(TaskEditStateLoading value) editingTask,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TaskEditStateInitial value)? task,
    TResult Function(TaskEditStateLoading value)? editingTask,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskEditStateInitial value)? task,
    TResult Function(TaskEditStateLoading value)? editingTask,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskEditStateCopyWith<TaskEditState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskEditStateCopyWith<$Res> {
  factory $TaskEditStateCopyWith(
          TaskEditState value, $Res Function(TaskEditState) then) =
      _$TaskEditStateCopyWithImpl<$Res>;
  $Res call(
      {TextEditingController textController,
      Priority importance,
      int? deadline});
}

/// @nodoc
class _$TaskEditStateCopyWithImpl<$Res>
    implements $TaskEditStateCopyWith<$Res> {
  _$TaskEditStateCopyWithImpl(this._value, this._then);

  final TaskEditState _value;
  // ignore: unused_field
  final $Res Function(TaskEditState) _then;

  @override
  $Res call({
    Object? textController = freezed,
    Object? importance = freezed,
    Object? deadline = freezed,
  }) {
    return _then(_value.copyWith(
      textController: textController == freezed
          ? _value.textController
          : textController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      importance: importance == freezed
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Priority,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$TaskEditStateInitialCopyWith<$Res>
    implements $TaskEditStateCopyWith<$Res> {
  factory _$$TaskEditStateInitialCopyWith(_$TaskEditStateInitial value,
          $Res Function(_$TaskEditStateInitial) then) =
      __$$TaskEditStateInitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {TextEditingController textController,
      Priority importance,
      int? deadline});
}

/// @nodoc
class __$$TaskEditStateInitialCopyWithImpl<$Res>
    extends _$TaskEditStateCopyWithImpl<$Res>
    implements _$$TaskEditStateInitialCopyWith<$Res> {
  __$$TaskEditStateInitialCopyWithImpl(_$TaskEditStateInitial _value,
      $Res Function(_$TaskEditStateInitial) _then)
      : super(_value, (v) => _then(v as _$TaskEditStateInitial));

  @override
  _$TaskEditStateInitial get _value => super._value as _$TaskEditStateInitial;

  @override
  $Res call({
    Object? textController = freezed,
    Object? importance = freezed,
    Object? deadline = freezed,
  }) {
    return _then(_$TaskEditStateInitial(
      textController: textController == freezed
          ? _value.textController
          : textController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      importance: importance == freezed
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Priority,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$TaskEditStateInitial implements TaskEditStateInitial {
  const _$TaskEditStateInitial(
      {required this.textController, required this.importance, this.deadline});

  @override
  final TextEditingController textController;
  @override
  final Priority importance;
  @override
  final int? deadline;

  @override
  String toString() {
    return 'TaskEditState.task(textController: $textController, importance: $importance, deadline: $deadline)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskEditStateInitial &&
            const DeepCollectionEquality()
                .equals(other.textController, textController) &&
            const DeepCollectionEquality()
                .equals(other.importance, importance) &&
            const DeepCollectionEquality().equals(other.deadline, deadline));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(textController),
      const DeepCollectionEquality().hash(importance),
      const DeepCollectionEquality().hash(deadline));

  @JsonKey(ignore: true)
  @override
  _$$TaskEditStateInitialCopyWith<_$TaskEditStateInitial> get copyWith =>
      __$$TaskEditStateInitialCopyWithImpl<_$TaskEditStateInitial>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TextEditingController textController,
            Priority importance, int? deadline)
        task,
    required TResult Function(
            Task editingTask,
            TextEditingController textController,
            Priority importance,
            int? deadline)
        editingTask,
  }) {
    return task(textController, importance, deadline);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TextEditingController textController, Priority importance,
            int? deadline)?
        task,
    TResult Function(Task editingTask, TextEditingController textController,
            Priority importance, int? deadline)?
        editingTask,
  }) {
    return task?.call(textController, importance, deadline);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TextEditingController textController, Priority importance,
            int? deadline)?
        task,
    TResult Function(Task editingTask, TextEditingController textController,
            Priority importance, int? deadline)?
        editingTask,
    required TResult orElse(),
  }) {
    if (task != null) {
      return task(textController, importance, deadline);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskEditStateInitial value) task,
    required TResult Function(TaskEditStateLoading value) editingTask,
  }) {
    return task(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TaskEditStateInitial value)? task,
    TResult Function(TaskEditStateLoading value)? editingTask,
  }) {
    return task?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskEditStateInitial value)? task,
    TResult Function(TaskEditStateLoading value)? editingTask,
    required TResult orElse(),
  }) {
    if (task != null) {
      return task(this);
    }
    return orElse();
  }
}

abstract class TaskEditStateInitial implements TaskEditState {
  const factory TaskEditStateInitial(
      {required final TextEditingController textController,
      required final Priority importance,
      final int? deadline}) = _$TaskEditStateInitial;

  @override
  TextEditingController get textController;
  @override
  Priority get importance;
  @override
  int? get deadline;
  @override
  @JsonKey(ignore: true)
  _$$TaskEditStateInitialCopyWith<_$TaskEditStateInitial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskEditStateLoadingCopyWith<$Res>
    implements $TaskEditStateCopyWith<$Res> {
  factory _$$TaskEditStateLoadingCopyWith(_$TaskEditStateLoading value,
          $Res Function(_$TaskEditStateLoading) then) =
      __$$TaskEditStateLoadingCopyWithImpl<$Res>;
  @override
  $Res call(
      {Task editingTask,
      TextEditingController textController,
      Priority importance,
      int? deadline});

  $TaskCopyWith<$Res> get editingTask;
}

/// @nodoc
class __$$TaskEditStateLoadingCopyWithImpl<$Res>
    extends _$TaskEditStateCopyWithImpl<$Res>
    implements _$$TaskEditStateLoadingCopyWith<$Res> {
  __$$TaskEditStateLoadingCopyWithImpl(_$TaskEditStateLoading _value,
      $Res Function(_$TaskEditStateLoading) _then)
      : super(_value, (v) => _then(v as _$TaskEditStateLoading));

  @override
  _$TaskEditStateLoading get _value => super._value as _$TaskEditStateLoading;

  @override
  $Res call({
    Object? editingTask = freezed,
    Object? textController = freezed,
    Object? importance = freezed,
    Object? deadline = freezed,
  }) {
    return _then(_$TaskEditStateLoading(
      editingTask: editingTask == freezed
          ? _value.editingTask
          : editingTask // ignore: cast_nullable_to_non_nullable
              as Task,
      textController: textController == freezed
          ? _value.textController
          : textController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      importance: importance == freezed
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Priority,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  @override
  $TaskCopyWith<$Res> get editingTask {
    return $TaskCopyWith<$Res>(_value.editingTask, (value) {
      return _then(_value.copyWith(editingTask: value));
    });
  }
}

/// @nodoc

class _$TaskEditStateLoading implements TaskEditStateLoading {
  const _$TaskEditStateLoading(
      {required this.editingTask,
      required this.textController,
      required this.importance,
      this.deadline});

  @override
  final Task editingTask;
  @override
  final TextEditingController textController;
  @override
  final Priority importance;
  @override
  final int? deadline;

  @override
  String toString() {
    return 'TaskEditState.editingTask(editingTask: $editingTask, textController: $textController, importance: $importance, deadline: $deadline)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskEditStateLoading &&
            const DeepCollectionEquality()
                .equals(other.editingTask, editingTask) &&
            const DeepCollectionEquality()
                .equals(other.textController, textController) &&
            const DeepCollectionEquality()
                .equals(other.importance, importance) &&
            const DeepCollectionEquality().equals(other.deadline, deadline));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(editingTask),
      const DeepCollectionEquality().hash(textController),
      const DeepCollectionEquality().hash(importance),
      const DeepCollectionEquality().hash(deadline));

  @JsonKey(ignore: true)
  @override
  _$$TaskEditStateLoadingCopyWith<_$TaskEditStateLoading> get copyWith =>
      __$$TaskEditStateLoadingCopyWithImpl<_$TaskEditStateLoading>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TextEditingController textController,
            Priority importance, int? deadline)
        task,
    required TResult Function(
            Task editingTask,
            TextEditingController textController,
            Priority importance,
            int? deadline)
        editingTask,
  }) {
    return editingTask(this.editingTask, textController, importance, deadline);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TextEditingController textController, Priority importance,
            int? deadline)?
        task,
    TResult Function(Task editingTask, TextEditingController textController,
            Priority importance, int? deadline)?
        editingTask,
  }) {
    return editingTask?.call(
        this.editingTask, textController, importance, deadline);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TextEditingController textController, Priority importance,
            int? deadline)?
        task,
    TResult Function(Task editingTask, TextEditingController textController,
            Priority importance, int? deadline)?
        editingTask,
    required TResult orElse(),
  }) {
    if (editingTask != null) {
      return editingTask(
          this.editingTask, textController, importance, deadline);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskEditStateInitial value) task,
    required TResult Function(TaskEditStateLoading value) editingTask,
  }) {
    return editingTask(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TaskEditStateInitial value)? task,
    TResult Function(TaskEditStateLoading value)? editingTask,
  }) {
    return editingTask?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskEditStateInitial value)? task,
    TResult Function(TaskEditStateLoading value)? editingTask,
    required TResult orElse(),
  }) {
    if (editingTask != null) {
      return editingTask(this);
    }
    return orElse();
  }
}

abstract class TaskEditStateLoading implements TaskEditState {
  const factory TaskEditStateLoading(
      {required final Task editingTask,
      required final TextEditingController textController,
      required final Priority importance,
      final int? deadline}) = _$TaskEditStateLoading;

  Task get editingTask;
  @override
  TextEditingController get textController;
  @override
  Priority get importance;
  @override
  int? get deadline;
  @override
  @JsonKey(ignore: true)
  _$$TaskEditStateLoadingCopyWith<_$TaskEditStateLoading> get copyWith =>
      throw _privateConstructorUsedError;
}
