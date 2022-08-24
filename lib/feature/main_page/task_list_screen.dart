import 'dart:developer';

import 'package:done/assets/theme/theme.dart';
import 'package:done/common/di/di_container.dart';
import 'package:done/common/services/navigation_service.dart';
import 'package:done/common/services/remote_config_service.dart';
import 'package:done/common/services/theme_pref_service.dart';
import 'package:done/common/services/theme_provider.dart';
import 'package:done/feature/main_page/bloc/tasklist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('tasklistscreen');
    //TODO: animatedlist
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          GetIt.I.get<NavigationService>().onTaskScreen();
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
                log('bloc builder');
                log(state.toString());
                if (state is TaskListLoadedState) {
                  log('bloc builder');
                  return _TaskListPage(
                    tasks: state.tasks,
                  );
                } else if (state is TaskListErrorState) {
                  return Center(
                    //SnackBar

                    child: Text('$state.message'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
      ),
    );
  }
}

class _TaskListPage extends StatefulWidget {
  const _TaskListPage({
    required this.tasks,
  });

  final List<Task> tasks;

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
    log(showDoneTasks.toString());
    if (showDoneTasks) {
      return widget.tasks;
    } else {
      return widget.tasks.where((element) => element.done == false).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    log('task list page');
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: _AppBarDelegate(
              doneTasksCounter:
                  widget.tasks.where((element) => element.done == true).length,
              showDoneTasks: showDoneTasks,
              callback: (value) => showFilteredList(showDoneTasks: value)),
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
                    for (var task
                        in showFilteredList(showDoneTasks: showDoneTasks))
                      _Item(task: task),
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
                  GetIt.I
                      .get<NavigationService>()
                      .onTaskScreen(task: widget.task);
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
            duration: const Duration(milliseconds: 100),
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
            bottom: 39,
            right: -10,
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
