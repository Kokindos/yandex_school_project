// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'task_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaskListState {
  bool get showDoneTasks => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Task> tasks, List<Task> visibledTasks,
            int doneTasksCounter, bool showDoneTasks)
        loaded,
    required TResult Function(bool showDoneTasks) loading,
    required TResult Function(String message, bool showDoneTasks) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Task> tasks, List<Task> visibledTasks,
            int doneTasksCounter, bool showDoneTasks)?
        loaded,
    TResult Function(bool showDoneTasks)? loading,
    TResult Function(String message, bool showDoneTasks)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Task> tasks, List<Task> visibledTasks,
            int doneTasksCounter, bool showDoneTasks)?
        loaded,
    TResult Function(bool showDoneTasks)? loading,
    TResult Function(String message, bool showDoneTasks)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskListStateInitial value) loaded,
    required TResult Function(TaskListStateLoading value) loading,
    required TResult Function(TaskListStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TaskListStateInitial value)? loaded,
    TResult Function(TaskListStateLoading value)? loading,
    TResult Function(TaskListStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskListStateInitial value)? loaded,
    TResult Function(TaskListStateLoading value)? loading,
    TResult Function(TaskListStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskListStateCopyWith<TaskListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskListStateCopyWith<$Res> {
  factory $TaskListStateCopyWith(
          TaskListState value, $Res Function(TaskListState) then) =
      _$TaskListStateCopyWithImpl<$Res>;
  $Res call({bool showDoneTasks});
}

/// @nodoc
class _$TaskListStateCopyWithImpl<$Res>
    implements $TaskListStateCopyWith<$Res> {
  _$TaskListStateCopyWithImpl(this._value, this._then);

  final TaskListState _value;
  // ignore: unused_field
  final $Res Function(TaskListState) _then;

  @override
  $Res call({
    Object? showDoneTasks = freezed,
  }) {
    return _then(_value.copyWith(
      showDoneTasks: showDoneTasks == freezed
          ? _value.showDoneTasks
          : showDoneTasks // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$TaskListStateInitialCopyWith<$Res>
    implements $TaskListStateCopyWith<$Res> {
  factory _$$TaskListStateInitialCopyWith(_$TaskListStateInitial value,
          $Res Function(_$TaskListStateInitial) then) =
      __$$TaskListStateInitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Task> tasks,
      List<Task> visibledTasks,
      int doneTasksCounter,
      bool showDoneTasks});
}

/// @nodoc
class __$$TaskListStateInitialCopyWithImpl<$Res>
    extends _$TaskListStateCopyWithImpl<$Res>
    implements _$$TaskListStateInitialCopyWith<$Res> {
  __$$TaskListStateInitialCopyWithImpl(_$TaskListStateInitial _value,
      $Res Function(_$TaskListStateInitial) _then)
      : super(_value, (v) => _then(v as _$TaskListStateInitial));

  @override
  _$TaskListStateInitial get _value => super._value as _$TaskListStateInitial;

  @override
  $Res call({
    Object? tasks = freezed,
    Object? visibledTasks = freezed,
    Object? doneTasksCounter = freezed,
    Object? showDoneTasks = freezed,
  }) {
    return _then(_$TaskListStateInitial(
      tasks: tasks == freezed
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      visibledTasks: visibledTasks == freezed
          ? _value._visibledTasks
          : visibledTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      doneTasksCounter: doneTasksCounter == freezed
          ? _value.doneTasksCounter
          : doneTasksCounter // ignore: cast_nullable_to_non_nullable
              as int,
      showDoneTasks: showDoneTasks == freezed
          ? _value.showDoneTasks
          : showDoneTasks // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TaskListStateInitial implements TaskListStateInitial {
  const _$TaskListStateInitial(
      {required final List<Task> tasks,
      required final List<Task> visibledTasks,
      required this.doneTasksCounter,
      required this.showDoneTasks})
      : _tasks = tasks,
        _visibledTasks = visibledTasks;

  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  final List<Task> _visibledTasks;
  @override
  List<Task> get visibledTasks {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visibledTasks);
  }

  @override
  final int doneTasksCounter;
  @override
  final bool showDoneTasks;

  @override
  String toString() {
    return 'TaskListState.loaded(tasks: $tasks, visibledTasks: $visibledTasks, doneTasksCounter: $doneTasksCounter, showDoneTasks: $showDoneTasks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskListStateInitial &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            const DeepCollectionEquality()
                .equals(other._visibledTasks, _visibledTasks) &&
            const DeepCollectionEquality()
                .equals(other.doneTasksCounter, doneTasksCounter) &&
            const DeepCollectionEquality()
                .equals(other.showDoneTasks, showDoneTasks));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tasks),
      const DeepCollectionEquality().hash(_visibledTasks),
      const DeepCollectionEquality().hash(doneTasksCounter),
      const DeepCollectionEquality().hash(showDoneTasks));

  @JsonKey(ignore: true)
  @override
  _$$TaskListStateInitialCopyWith<_$TaskListStateInitial> get copyWith =>
      __$$TaskListStateInitialCopyWithImpl<_$TaskListStateInitial>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Task> tasks, List<Task> visibledTasks,
            int doneTasksCounter, bool showDoneTasks)
        loaded,
    required TResult Function(bool showDoneTasks) loading,
    required TResult Function(String message, bool showDoneTasks) error,
  }) {
    return loaded(tasks, visibledTasks, doneTasksCounter, showDoneTasks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Task> tasks, List<Task> visibledTasks,
            int doneTasksCounter, bool showDoneTasks)?
        loaded,
    TResult Function(bool showDoneTasks)? loading,
    TResult Function(String message, bool showDoneTasks)? error,
  }) {
    return loaded?.call(tasks, visibledTasks, doneTasksCounter, showDoneTasks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Task> tasks, List<Task> visibledTasks,
            int doneTasksCounter, bool showDoneTasks)?
        loaded,
    TResult Function(bool showDoneTasks)? loading,
    TResult Function(String message, bool showDoneTasks)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(tasks, visibledTasks, doneTasksCounter, showDoneTasks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskListStateInitial value) loaded,
    required TResult Function(TaskListStateLoading value) loading,
    required TResult Function(TaskListStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TaskListStateInitial value)? loaded,
    TResult Function(TaskListStateLoading value)? loading,
    TResult Function(TaskListStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskListStateInitial value)? loaded,
    TResult Function(TaskListStateLoading value)? loading,
    TResult Function(TaskListStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class TaskListStateInitial implements TaskListState {
  const factory TaskListStateInitial(
      {required final List<Task> tasks,
      required final List<Task> visibledTasks,
      required final int doneTasksCounter,
      required final bool showDoneTasks}) = _$TaskListStateInitial;

  List<Task> get tasks;
  List<Task> get visibledTasks;
  int get doneTasksCounter;
  @override
  bool get showDoneTasks;
  @override
  @JsonKey(ignore: true)
  _$$TaskListStateInitialCopyWith<_$TaskListStateInitial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskListStateLoadingCopyWith<$Res>
    implements $TaskListStateCopyWith<$Res> {
  factory _$$TaskListStateLoadingCopyWith(_$TaskListStateLoading value,
          $Res Function(_$TaskListStateLoading) then) =
      __$$TaskListStateLoadingCopyWithImpl<$Res>;
  @override
  $Res call({bool showDoneTasks});
}

/// @nodoc
class __$$TaskListStateLoadingCopyWithImpl<$Res>
    extends _$TaskListStateCopyWithImpl<$Res>
    implements _$$TaskListStateLoadingCopyWith<$Res> {
  __$$TaskListStateLoadingCopyWithImpl(_$TaskListStateLoading _value,
      $Res Function(_$TaskListStateLoading) _then)
      : super(_value, (v) => _then(v as _$TaskListStateLoading));

  @override
  _$TaskListStateLoading get _value => super._value as _$TaskListStateLoading;

  @override
  $Res call({
    Object? showDoneTasks = freezed,
  }) {
    return _then(_$TaskListStateLoading(
      showDoneTasks: showDoneTasks == freezed
          ? _value.showDoneTasks
          : showDoneTasks // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TaskListStateLoading implements TaskListStateLoading {
  const _$TaskListStateLoading({required this.showDoneTasks});

  @override
  final bool showDoneTasks;

  @override
  String toString() {
    return 'TaskListState.loading(showDoneTasks: $showDoneTasks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskListStateLoading &&
            const DeepCollectionEquality()
                .equals(other.showDoneTasks, showDoneTasks));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(showDoneTasks));

  @JsonKey(ignore: true)
  @override
  _$$TaskListStateLoadingCopyWith<_$TaskListStateLoading> get copyWith =>
      __$$TaskListStateLoadingCopyWithImpl<_$TaskListStateLoading>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Task> tasks, List<Task> visibledTasks,
            int doneTasksCounter, bool showDoneTasks)
        loaded,
    required TResult Function(bool showDoneTasks) loading,
    required TResult Function(String message, bool showDoneTasks) error,
  }) {
    return loading(showDoneTasks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Task> tasks, List<Task> visibledTasks,
            int doneTasksCounter, bool showDoneTasks)?
        loaded,
    TResult Function(bool showDoneTasks)? loading,
    TResult Function(String message, bool showDoneTasks)? error,
  }) {
    return loading?.call(showDoneTasks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Task> tasks, List<Task> visibledTasks,
            int doneTasksCounter, bool showDoneTasks)?
        loaded,
    TResult Function(bool showDoneTasks)? loading,
    TResult Function(String message, bool showDoneTasks)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(showDoneTasks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskListStateInitial value) loaded,
    required TResult Function(TaskListStateLoading value) loading,
    required TResult Function(TaskListStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TaskListStateInitial value)? loaded,
    TResult Function(TaskListStateLoading value)? loading,
    TResult Function(TaskListStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskListStateInitial value)? loaded,
    TResult Function(TaskListStateLoading value)? loading,
    TResult Function(TaskListStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TaskListStateLoading implements TaskListState {
  const factory TaskListStateLoading({required final bool showDoneTasks}) =
      _$TaskListStateLoading;

  @override
  bool get showDoneTasks;
  @override
  @JsonKey(ignore: true)
  _$$TaskListStateLoadingCopyWith<_$TaskListStateLoading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskListStateErrorCopyWith<$Res>
    implements $TaskListStateCopyWith<$Res> {
  factory _$$TaskListStateErrorCopyWith(_$TaskListStateError value,
          $Res Function(_$TaskListStateError) then) =
      __$$TaskListStateErrorCopyWithImpl<$Res>;
  @override
  $Res call({String message, bool showDoneTasks});
}

/// @nodoc
class __$$TaskListStateErrorCopyWithImpl<$Res>
    extends _$TaskListStateCopyWithImpl<$Res>
    implements _$$TaskListStateErrorCopyWith<$Res> {
  __$$TaskListStateErrorCopyWithImpl(
      _$TaskListStateError _value, $Res Function(_$TaskListStateError) _then)
      : super(_value, (v) => _then(v as _$TaskListStateError));

  @override
  _$TaskListStateError get _value => super._value as _$TaskListStateError;

  @override
  $Res call({
    Object? message = freezed,
    Object? showDoneTasks = freezed,
  }) {
    return _then(_$TaskListStateError(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      showDoneTasks: showDoneTasks == freezed
          ? _value.showDoneTasks
          : showDoneTasks // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TaskListStateError implements TaskListStateError {
  const _$TaskListStateError(
      {required this.message, required this.showDoneTasks});

  @override
  final String message;
  @override
  final bool showDoneTasks;

  @override
  String toString() {
    return 'TaskListState.error(message: $message, showDoneTasks: $showDoneTasks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskListStateError &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality()
                .equals(other.showDoneTasks, showDoneTasks));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(showDoneTasks));

  @JsonKey(ignore: true)
  @override
  _$$TaskListStateErrorCopyWith<_$TaskListStateError> get copyWith =>
      __$$TaskListStateErrorCopyWithImpl<_$TaskListStateError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Task> tasks, List<Task> visibledTasks,
            int doneTasksCounter, bool showDoneTasks)
        loaded,
    required TResult Function(bool showDoneTasks) loading,
    required TResult Function(String message, bool showDoneTasks) error,
  }) {
    return error(message, showDoneTasks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Task> tasks, List<Task> visibledTasks,
            int doneTasksCounter, bool showDoneTasks)?
        loaded,
    TResult Function(bool showDoneTasks)? loading,
    TResult Function(String message, bool showDoneTasks)? error,
  }) {
    return error?.call(message, showDoneTasks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Task> tasks, List<Task> visibledTasks,
            int doneTasksCounter, bool showDoneTasks)?
        loaded,
    TResult Function(bool showDoneTasks)? loading,
    TResult Function(String message, bool showDoneTasks)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, showDoneTasks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskListStateInitial value) loaded,
    required TResult Function(TaskListStateLoading value) loading,
    required TResult Function(TaskListStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TaskListStateInitial value)? loaded,
    TResult Function(TaskListStateLoading value)? loading,
    TResult Function(TaskListStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskListStateInitial value)? loaded,
    TResult Function(TaskListStateLoading value)? loading,
    TResult Function(TaskListStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TaskListStateError implements TaskListState {
  const factory TaskListStateError(
      {required final String message,
      required final bool showDoneTasks}) = _$TaskListStateError;

  String get message;
  @override
  bool get showDoneTasks;
  @override
  @JsonKey(ignore: true)
  _$$TaskListStateErrorCopyWith<_$TaskListStateError> get copyWith =>
      throw _privateConstructorUsedError;
}
