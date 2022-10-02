
import 'package:done/common/services/remote_config_service.dart';
import 'package:diffutil_sliverlist/diffutil_sliverlist.dart';
import 'package:done/feature/app/navigator/app_navigator.dart';
import 'package:done/feature/main_page/bloc/tasklist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:get_it/get_it.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({
    Key? key,
    required this.navigatorCallback,
  }) : super(key: key);

  final Function(Task task) navigatorCallback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          GetIt.I.get<AppNavigator>().navigationDelegate.createNewTask();
        },
      ),
      body: SafeArea(
        child: BlocListener<TaskListBloc, TaskListState>(
          listener: (context, state) {
            if (state is TaskListErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('Error: ${state.message.toString()}, try again'),
                ),
              );
            }
          },
          child: BlocBuilder<TaskListBloc, TaskListState>(
            builder: (context, state) {
              return state.when(
                loaded: (tasks) {
                  return _TaskListPage(
                      tasks: tasks, navigatorCallback: navigatorCallback);
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (_, tasks) {
                  return _TaskListPage(
                      tasks: tasks, navigatorCallback: navigatorCallback);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TaskListPage extends StatefulWidget {
  const _TaskListPage({
    required this.tasks,
    required this.navigatorCallback,
  });

  final List<Task> tasks;
  final Function(Task task) navigatorCallback;

  @override
  State<_TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<_TaskListPage> {
  TextEditingController textEditingController = TextEditingController();
  bool showDoneTasks = true;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  List<Task> showFilteredList({required bool showDoneTasks}) {
    setState(() {
      this.showDoneTasks = showDoneTasks;
    });
    List<Task> newlist = List.from(widget.tasks);
    newlist.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    if (showDoneTasks) {
      return newlist;
    } else {
      return newlist.where((element) => element.done == false).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future(() {
        BlocProvider.of<TaskListBloc>(context).add(const GetListEvent());
      }),
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _AppBarDelegate(
                doneTasksCounter: widget.tasks
                    .where((element) => element.done == true)
                    .length,
                showDoneTasks: showDoneTasks,
                callback: (value) => showFilteredList(showDoneTasks: value)),
            pinned: true,
            floating: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            sliver: SliverStack(
              children: [
                SliverPositioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          color: Color.fromRGBO(0, 0, 0, 0.12),
                        ),
                        BoxShadow(
                          offset: Offset(0, 0),
                          color: Color.fromRGBO(0, 0, 0, 0.06),
                        )
                      ],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                MultiSliver(
                  children: [
                    DiffUtilSliverList<Task>(
                      items: showFilteredList(showDoneTasks: showDoneTasks),
                      builder: (context, item) => _Item(
                        key: ValueKey(item.id),
                        task: item,
                        navigatorCallback: widget.navigatorCallback,
                      ),
                      insertAnimationBuilder: (context, animation, child) =>
                          ScaleTransition(
                        //sizeFactor: animation,
                        scale: animation,
                        child: child,
                      ),
                      removeAnimationBuilder: (context, animation, child) =>
                          SizeTransition(
                        sizeFactor: animation,
                        child: child,
                      ),
                      removeAnimationDuration:
                          const Duration(milliseconds: 150),
                      insertAnimationDuration:
                          const Duration(milliseconds: 300),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.done,
                        controller: textEditingController,
                        onSubmitted: (value) {
                          if (textEditingController.text != '') {
                            BlocProvider.of<TaskListBloc>(context).add(
                                CreateTaskEvent(textEditingController.text));
                            textEditingController.clear();
                          }
                        },
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatefulWidget {
  final Function(Task task) navigatorCallback;

  final Task task;

  const _Item({
    Key? key,
    required this.task,
    required this.navigatorCallback,
  }) : super(key: key);

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  var leftIconPadding = 27.0;

  Future<bool?> dismissDirectionFunc(DismissDirection direction) async {
    if (direction == DismissDirection.startToEnd) {
      BlocProvider.of<TaskListBloc>(context).add(
        EditTaskEvent(
          task: widget.task.copyWith(done: !widget.task.done),
        ),
      );
      return false;
    } else {
      BlocProvider.of<TaskListBloc>(context)
          .add(DeleteTaskEvent(task: widget.task));
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
        color: Theme.of(context).errorColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            SizedBox(
              width: leftIconPadding,
            ),
          ],
        ),
      ),
      key: ObjectKey(widget.task),
      background: Container(
        color: Theme.of(context).toggleableActiveColor,
        child: Row(
          children: [
            SizedBox(
              width: leftIconPadding,
            ),
            const Icon(
              Icons.done,
              color: Colors.white,
            ),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () => BlocProvider.of<TaskListBloc>(context).add(
          EditTaskEvent(
            task: widget.task.copyWith(done: !widget.task.done),
          ),
        ),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  if (widget.task.importance == Priority.important)
                    Container(
                      height: 15,
                      width: 15,
                      color: GetIt.I
                          .get<RemoteConfigService>()
                          .getColor
                          .withOpacity(.2),
                    ),
                  Checkbox(
                    value: widget.task.done,
                    onChanged: (value) {
                      BlocProvider.of<TaskListBloc>(context).add(
                        EditTaskEvent(
                          task: widget.task.copyWith(done: !widget.task.done),
                        ),
                      );
                    },
                    side: BorderSide(
                        width: 2,
                        color: widget.task.importance == Priority.important
                            ? GetIt.I.get<RemoteConfigService>().getColor
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
                                      color: GetIt.I
                                          .get<RemoteConfigService>()
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
                  widget.navigatorCallback(widget.task);
                },
                icon: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).hintColor,
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
    required this.showDoneTasks,
    required this.callback,
  });

  final int doneTasksCounter;
  final bool showDoneTasks;
  final Function(bool showDoneTasks) callback;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = shrinkOffset / maxExtent;
    return Material(
      elevation: shrinkOffset < delta ? 0 : 4,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedContainer(
            color: Theme.of(context).scaffoldBackgroundColor,
            duration: const Duration(milliseconds: 30),
            padding: EdgeInsets.lerp(const EdgeInsets.only(left: 52, top: 82),
                const EdgeInsets.only(left: 16, top: 16), progress),
            child: Text(
              AppLocalizations.of(context)!.myTasks,
              style: TextStyle.lerp(Theme.of(context).textTheme.headline1!,
                  Theme.of(context).textTheme.headline2!, progress),
            ),
          ),
          Container(
            padding: EdgeInsets.lerp(const EdgeInsets.only(left: 52, top: 126),
                const EdgeInsets.only(left: 16, top: 25), progress),
            child: AnimatedOpacity(
              opacity: 1 - progress,
              duration: const Duration(milliseconds: 1),
              child: Text(
                '${AppLocalizations.of(context)!.done} - $doneTasksCounter',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
              ),
            ),
          ),
          Positioned(
            bottom: 4,
            right: -8,
            child:
                _HideButton(showDoneTasks: showDoneTasks, callback: callback),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 164;

  @override
  double get minExtent => 64;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    if (oldDelegate != this) {
      return true;
    }
    return false;
  }
}

class _HideButton extends StatelessWidget {
  const _HideButton({required this.showDoneTasks, required this.callback});

  final bool showDoneTasks;
  final Function(bool showDoneTasks) callback;

  @override
  Widget build(BuildContext context) {
    {
      return Container(
        padding: const EdgeInsets.only(right: 16),
        child: IconButton(
          onPressed: () {
            callback(!showDoneTasks);
          },
          icon: showDoneTasks
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
          color: Theme.of(context).primaryColor,
        ),
      );
    }
  }
}
