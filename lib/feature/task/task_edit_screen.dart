import 'dart:developer';

import 'package:done/assets/theme/theme.dart';
import 'package:done/common/services/navigation_service.dart';
import 'package:done/common/services/remote_config_service.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/app/repositories/task_network_repository.dart';
import 'package:done/feature/main_page/bloc/tasklist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class TaskScreen extends StatefulWidget {
  final Task? task;

  const TaskScreen({Key? key, this.task}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final navigationService = context.read<NavigationService>();
    return _TaskPage(navigationService, widget.task);
  }
}

class _TaskPage extends StatefulWidget {
  _TaskPage(
    this.navigationService,
    this.task,
  );

  final NavigationService navigationService;

  Task? task;

  @override
  State<_TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<_TaskPage> {
  late TextEditingController textController = TextEditingController(text: task.text);
  var scrollOverflow = false;
  late Task task;
  late bool isNew;

  @override
  void initState() {
    if (widget.task == null) {
      task = Task(
          id: const Uuid().v1(),
          text: '',
          done: false,
          importance: Priority.basic);
      isNew = true;
    } else {
      task = widget.task!;
      isNew = false;
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2122));
    setState(() {
      task = task.copyWith(deadline: pickedDate?.microsecondsSinceEpoch);
    });
    return pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: scrollOverflow ? 4 : 0,
        leading: IconButton(
          onPressed: widget.navigationService.onPop,
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed: () {
              BlocProvider.of<TaskListBloc>(context).add(isNew
                  ? CreateTaskEvent(textController.text,
                      deadline: task.deadline, importance: task.importance)
                  : EditTaskEvent(task: task));
              widget.navigationService.onPop();
            },
            child: Text(
              AppLocalizations.of(context)!.save,
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: (n) {
            if (n.metrics.pixels > 40) {
              setState(() {
                scrollOverflow = true;
              });
            } else {
              setState(() {
                scrollOverflow = false;
              });
            }
            return true;
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const SizedBox(
                height: 8,
              ),
              Builder(builder: (context) {
                final border = OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                );
                return Material(
                  elevation: 2.2,
                  shadowColor: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                  child: TextFormField(

                    textCapitalization: TextCapitalization.sentences,
                    controller: textController,
                    textInputAction: TextInputAction.go,
                    maxLines: null,
                    minLines: 4,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.needToDo,
                      fillColor: Theme.of(context).backgroundColor,
                      filled: true,
                      border: border,
                      disabledBorder: border,
                      enabledBorder: border,
                      focusedBorder: border,


                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 28,
              ),
              Text(AppLocalizations.of(context)!.importance),
              Row(
                children: [
                  DropdownButtonHideUnderline(
                    child: SizedBox(
                      height: 30,
                      width: 150,
                      child: DropdownButton<Priority>(
                        style: TextStyle(color: Theme.of(context).hintColor),
                        borderRadius: BorderRadius.circular(2),
                        iconDisabledColor: Colors.transparent,
                        iconEnabledColor: Colors.transparent,
                        value: task.importance,
                        items: [
                          DropdownMenuItem(
                            value: Priority.basic,
                            child: Text(
                              AppLocalizations.of(context)!.no,
                            ),
                          ),
                          DropdownMenuItem(
                            value: Priority.low,
                            child: Text(
                              AppLocalizations.of(context)!.low,
                            ),
                          ),
                          DropdownMenuItem(
                            value: Priority.important,
                            child: Text(
                              AppLocalizations.of(context)!.high,
                              style: TextStyle(
                                  color: context
                                      .read<RemoteConfigService>()
                                      .getColor),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            final newTask = task.copyWith(importance: value);
                            setState(() {
                              task = newTask;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.doneUntil),
                        if (task.deadline != null)
                          Text(
                            DateFormat('d MMMM y',
                                    AppLocalizations.of(context)?.localeName)
                                .format(DateTime.fromMicrosecondsSinceEpoch(
                                    task.deadline!)),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          )
                        else
                          const SizedBox(
                            height: 20,
                          ),
                      ],
                    ),
                  ),
                  Switch(
                      value: task.deadline != null,
                      onChanged: (value) {
                        if (value) {
                          _selectDate(context);
                        }
                        else {
                          setState(() {
                            value=!value;
                            task=task.copyWith(deadline: null);
                          });
                        }
                      }),
                ],
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(
                height: 15,
              ),
              isNew
                  ? Container(
                      width: 112,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 4,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Theme.of(context).disabledColor,
                          ),
                          const SizedBox(
                            width: 17,
                          ),
                          Text(
                            AppLocalizations.of(context)!.delete,
                            style: TextStyle(
                                color: Theme.of(context).disabledColor),
                          ),
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        BlocProvider.of<TaskListBloc>(context)
                            .add(DeleteTaskEvent(task: task));
                        widget.navigationService.onPop();
                      },
                      child: Container(
                        width: 112,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 4,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete,
                              color: AppTheme.red,
                            ),
                            const SizedBox(
                              width: 17,
                            ),
                            Text(
                              AppLocalizations.of(context)!.delete,
                              style: const TextStyle(color: AppTheme.red),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
