import 'package:flutter/material.dart';

import '../../../data/models/task_count.dart';
import '../../../data/models/task_list_model.dart';
import '../../../data/models/task_list_status_count_model.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/network_caller/network_response.dart';
import '../../../data/utility/urls.dart';
import '../../../style/style.dart';
import '../../widgets/profile_summary_card.dart';
import '../../widgets/tasks_count_summary_card.dart';
import '../../widgets/task_items_card.dart';
import 'add_new_tasks_screen.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  bool getTaskListInProgress = false;
  bool getTaskStatusCountInProgress = false;
  TaskListStatusCountModel taskListStatusCountModel =
  TaskListStatusCountModel();
  TaskListModel taskListModel = TaskListModel();

  Future<void> getTaskStatusCount() async {
    getTaskStatusCountInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
    await NetworkCaller.getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      taskListStatusCountModel =
          TaskListStatusCountModel.fromJson(response.jsonResponse);
    }
    getTaskStatusCountInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getTaskList() async {
    getTaskListInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.getTaskList);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getTaskListInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getTaskStatusCount();
    getTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Visibility(
              visible: getTaskStatusCountInProgress == false &&
                  (taskListStatusCountModel.taskCountList?.isNotEmpty ?? false),
              replacement: LinearProgressIndicator(
                color: PrimaryColor.color,
                backgroundColor: Colors.grey,
              ),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                  taskListStatusCountModel.taskCountList?.length ?? 0,
                  itemBuilder: (context, index) {
                    TaskCount taskCount =
                    taskListStatusCountModel.taskCountList![index];
                    return FittedBox(
                      child: TaskCountsSummaryCard(
                        summaryCount: taskCount.sum.toString(),
                        summaryTitle: taskCount.sId ?? '',
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: getTaskListInProgress == false,
                replacement: Center(
                  child: CircularProgressIndicator(color: PrimaryColor.color),
                ),
                child: RefreshIndicator(
                  color: PrimaryColor.color,
                  onRefresh: getTaskList,
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemsCard(
                        task: taskListModel.taskList![index],
                        onStatusChangeRefresh: () {
                          getTaskList();
                          getTaskStatusCount();
                        },
                        taskUpdateStatusInProgress: (inProgress) {
                          getTaskListInProgress = inProgress;
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        backgroundColor: PrimaryColor.color,
        child: const Icon(Icons.add),
      ),
    );
  }
}