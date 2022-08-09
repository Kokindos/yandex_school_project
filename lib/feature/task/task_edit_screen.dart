import 'package:done/assets/theme/theme.dart';
import 'package:done/common/services/navigation_service.dart';
import 'package:done/common/services/remote_config_service.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/app/repositories/task_repository.dart';
import 'package:done/feature/task/bloc/task_edit_bloc.dart';
import 'package:done/feature/task/bloc/task_edit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskScreen extends StatefulWidget {
  final Task? task;

  const TaskScreen({Key? key, this.task}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late NavigationService navigationService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    navigationService = context.read<NavigationService>();
  }

  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskEditBloc(
        context.read<TaskRepository>(),
        task: widget.task,
      ),
      child: BlocBuilder<TaskEditBloc, TaskEditState>(
        builder: (context, state) {
          return state.when(
            task: (textController, importance, deadline) => _TaskPage(
              navigationService,
              textController,
              importance,
              deadline,
            ),
            editingTask: (
              _,
              textController,
              importance,
              deadline,
            ) =>
                _TaskPage(
              navigationService,
              textController,
              importance,
              deadline,
            ),
          );
        },
      ),
    );
  }
}

class _TaskPage extends StatelessWidget {
  const _TaskPage(
    this.navigationService,
    this.textController,
    this.importance,
    this.deadline,
  );

  final NavigationService navigationService;
  final TextEditingController textController;
  final Priority importance;
  final int? deadline;

  Future<void> _selectDate(BuildContext context) async {
    final bloc = context.read<TaskEditBloc>();
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2122));
    if (pickedDate != null) {
      bloc.changeDeadline(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: navigationService.onPop,
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<TaskEditBloc>().saveTask();
              navigationService.onPop();
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
                      value: importance,
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
                          context.read<TaskEditBloc>().changePriority(value);
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
                      if (deadline != null)
                        Text(
                          DateFormat('d MMMM y',
                                  AppLocalizations.of(context)?.localeName)
                              .format(DateTime.fromMicrosecondsSinceEpoch(
                                  deadline!)),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      else
                        const SizedBox(
                          height: 20,
                        ),
                    ],
                  ),
                ),
                Switch(
                    value: deadline != null,
                    onChanged: (value) {
                      if (value) {
                        _selectDate(context);
                      } else {
                        context.read<TaskEditBloc>().changeDeadline(null);
                      }
                    }),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<TaskEditBloc, TaskEditState>(
              builder: (builder, state) {
                return state is TaskEditStateInitial
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
                          context.read<TaskEditBloc>().deleteTask();
                          navigationService.onPop();
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
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
