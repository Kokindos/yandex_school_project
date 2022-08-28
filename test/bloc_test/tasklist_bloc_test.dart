import 'package:bloc_test/bloc_test.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/app/repositories/task_connect_repository.dart';
import 'package:done/feature/main_page/bloc/tasklist_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskConnectRepository {}

class FakeTask extends Fake implements Task {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final tasklist = [
    const Task(
        id: '1',
        text: 'task1',
        done: false,
        createdAt: 10000,
        changedAt: 15000,
        importance: Priority.basic,
        lastUpdatedBy: 'android'),
    const Task(
        id: '2',
        text: 'task2',
        done: true,
        createdAt: 10000,
        changedAt: 15000,
        importance: Priority.low,
        lastUpdatedBy: 'android'),
    const Task(
        id: '3',
        text: 'task3',
        done: true,
        createdAt: 10000,
        changedAt: 15000,
        importance: Priority.basic,
        lastUpdatedBy: 'android'),
    const Task(
        id: '4',
        text: 'task4',
        done: false,
        createdAt: 14330,
        changedAt: 151400,
        importance: Priority.important,
        lastUpdatedBy: 'android'),
    const Task(
        id: '5',
        text: 'task5',
        done: false,
        createdAt: 12300,
        changedAt: 175400,
        importance: Priority.important,
        lastUpdatedBy: 'android'),
  ];
  var testTask = tasklist[0];
  final List<Task> tasklistDeleted = List.from(tasklist);
  tasklistDeleted.remove(testTask);

  group('TaskListBloc', () {
    late TaskListBloc bloc;
    late MockTaskRepository api;
    setUpAll(() {
      registerFallbackValue(FakeTask());
    });
    setUp(() {
      api = MockTaskRepository();
      bloc = TaskListBloc(taskRepository: api);
      when(
        () => api.getList(),
      ).thenAnswer((_) async => tasklist);
      when(() => api.createTask(task: any(named: 'task')))
          .thenAnswer((_) async => testTask);
    });
    tearDown(() => bloc.close());
    TaskListBloc blocBuild() {
      return TaskListBloc(taskRepository: api);
    }

    group('getList', () {
      test(
          'on GetListEvent emits TaskListLoadingState and TaskListLoadedState ',
          () {
        bloc.add(const GetListEvent());
        expectLater(
          bloc.stream,
          emitsInOrder(
            [
              equals(const TaskListLoadingState()),
              equals(TaskListLoadedState(tasks: tasklist))
            ],
          ),
        );
      });
    });
    group('constructor', () {
      test('returns normally', () => expect(blocBuild, returnsNormally));
      test(
        'initial state when bloc create in TaskListLoadingState',
        () {
          expect(
            blocBuild().state,
            equals(const TaskListState.loading()),
          );
        },
      );
    });
    group('DeleteTaskEvent', () {
      blocTest<TaskListBloc, TaskListState>(
        'emits state without deleted task',
        setUp: () {
          when(() => api.deleteTask(id: any(named: 'id')))
              .thenAnswer((_) async => testTask);
        },
        build: blocBuild,
        seed: () => TaskListLoadedState(tasks: tasklist),
        act: (bloc) => bloc.add(
          DeleteTaskEvent(task: testTask),
        ),
        expect: () => [
          TaskListLoadedState(tasks: tasklistDeleted),
        ],
      );
    });
  });
}
