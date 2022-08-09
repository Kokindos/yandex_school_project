import 'package:done/assets/theme/theme.dart';
import 'package:done/common/di/di_container.dart';
import 'package:done/common/services/navigation_service.dart';
import 'package:done/common/services/remote_config_service.dart';
import 'package:done/feature/main_page/bloc/task_list_bloc.dart';
import 'package:done/feature/main_page/bloc/task_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late NavigationService navigationService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    navigationService = context.read<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskListBloc(DIContainer.instance.taskRepository),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            navigationService.onTaskScreen();
          },
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            child: BlocBuilder<TaskListBloc, TaskListState>(
              builder: (context, state) {
                return state.when(
                  loaded:
                      (tasks, visibledTasks, doneTasksCounter, showDoneTasks) {
                    return _TaskListPage(
                      tasks: showDoneTasks ? tasks : visibledTasks,
                      doneTasksCounter: doneTasksCounter,
                      showDoneTasks: showDoneTasks,
                    );
                  },
                  error: (message, __) => Center(
                    child: Text('Error: $message'),
                  ),
                  loading: (_) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _TaskListPage extends StatefulWidget {
  const _TaskListPage({
    required this.tasks,
    required this.doneTasksCounter,
    required this.showDoneTasks,
  });

  final List<Task> tasks;
  final int doneTasksCounter;
  final bool showDoneTasks;

  @override
  State<_TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<_TaskListPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: _AppBarDelegate(doneTasksCounter: widget.doneTasksCounter),
          pinned: true,
          floating: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Material(
              borderRadius: BorderRadius.circular(16),
              elevation: 2.2,
              shadowColor: Colors.black54,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).backgroundColor,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  children: [
                    for (var task in widget.tasks) _Item(task: task),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: TextField(
                        textInputAction: TextInputAction.done,
                        controller: textEditingController,
                        onSubmitted: (value) => context
                            .read<TaskListBloc>()
                            .createQuickTask(
                                textController: textEditingController),
                        maxLines: null,
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.newTask,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
      ],
    );
  }
}

class _Item extends StatefulWidget {
  final Task task;

  const _Item({Key? key, required this.task}) : super(key: key);

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  var leftIconPadding = 27.0;
  late NavigationService navigationService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    navigationService = context.read<NavigationService>();
  }

  Future<bool?> dismissDirectionFunc(DismissDirection direction) async {
    if (direction == DismissDirection.startToEnd) {
      context.read<TaskListBloc>().setDoneTask(widget.task);
      return false;
    } else {
      context.read<TaskListBloc>().deleteTask(widget.task);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onUpdate: (d) {
        setState(() {
          leftIconPadding =
              27 + d.progress * (MediaQuery.of(context).size.width / 2 - 54);
        });
      },
      confirmDismiss: dismissDirectionFunc,
      onDismissed: (direction) {},
      secondaryBackground: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: Theme.of(context).backgroundColor,
            ),
            SizedBox(
              width: leftIconPadding,
            ),
          ],
        ),
      ),
      key: ObjectKey(widget.task),
      background: Container(
        color: Colors.green,
        child: Row(
          children: [
            SizedBox(
              width: leftIconPadding,
            ),
            Icon(
              Icons.done,
              color: Theme.of(context).backgroundColor,
            ),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () => context.read<TaskListBloc>().setDoneTask(widget.task),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  if (widget.task.importance == Priority.important)
                    Container(
                      height: 15,
                      width: 15,
                      color: context
                          .read<RemoteConfigService>()
                          .getColor
                          .withOpacity(.2),
                    ),
                  Checkbox(
                    value: widget.task.done,
                    onChanged: (value) {
                      context.read<TaskListBloc>().setDoneTask(widget.task);
                    },
                    activeColor: AppTheme.green,
                    side: BorderSide(
                        width: 2,
                        color: widget.task.importance == Priority.important
                            ? context.read<RemoteConfigService>().getColor
                            : Theme.of(context).dividerColor),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.task.done == true)
                        Text(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          widget.task.text,
                          style: Theme.of(context)
                              .textTheme
                              .overline!
                              .copyWith(decoration: TextDecoration.lineThrough),
                        )
                      else
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.task.importance != Priority.basic)
                                if (widget.task.importance == Priority.low)
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 6, top: 3),
                                    child: SvgPicture.asset(
                                      'lib/assets/icons/icon_low.svg',
                                      allowDrawingOutsideViewBox: true,
                                    ),
                                  )
                                else
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: SvgPicture.asset(
                                      'lib/assets/icons/icon_important.svg',
                                      color: context
                                          .read<RemoteConfigService>()
                                          .getColor,
                                      allowDrawingOutsideViewBox: true,
                                    ),
                                  ),
                              Flexible(
                                child: Text(
                                  widget.task.text,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]),
                      if (widget.task.deadline != null)
                        Text(
                          DateFormat('d MMMM y',
                                  AppLocalizations.of(context)?.localeName)
                              .format(
                            DateTime.fromMicrosecondsSinceEpoch(
                                widget.task.deadline!),
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .overline!
                                      .color),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              IconButton(
                onPressed: () {
                  navigationService.onTaskScreen(task: widget.task);
                },
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.black.withOpacity(.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBarDelegate extends SliverPersistentHeaderDelegate {
  final delta = 50;

  _AppBarDelegate({
    required this.doneTasksCounter,
  });

  final int doneTasksCounter;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      elevation: shrinkOffset < delta ? 0 : 5,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.only(
          left: shrinkOffset < delta ? 52 : 16,
          top: shrinkOffset < delta ? 50 : 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.myTasks,
                  style: shrinkOffset < delta
                      ? Theme.of(context).textTheme.headline1!
                      : Theme.of(context).textTheme.headline2!,
                ),
                if (shrinkOffset > delta) const _HideButton(),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            if (shrinkOffset < delta)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.done} - $doneTasksCounter',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .color!
                              .withOpacity(.3),
                        ),
                  ),
                  const _HideButton(),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    if (oldDelegate != this) {
      return true;
    }

    return false;
  }
}

class _HideButton extends StatelessWidget {
  const _HideButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListBloc, TaskListState>(builder: (context, state) {
      return state.when(
        loaded: (_, visibledTasks, doneTasksCounter, showDoneTasks) {
          return Container(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                context.read<TaskListBloc>().switchListVisibility();
              },
              icon: showDoneTasks
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
              color: Theme.of(context).primaryColor,
            ),
          );
        },
        error: (message, __) => Container(),
        loading: (_) => Container(),
      );
    });
  }
}
