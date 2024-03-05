import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/get_task_list_controller.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/get_task_list_status_count_controller.dart';
import '../../../../data/models/task_count.dart';
import '../../presentation_utility/style.dart';
import '../../widgets/profile_summary_card.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/task_items_card.dart';
import 'add_new_tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetTaskListController taskListController =
  Get.find<GetTaskListController>();
  final GetTaskListStatusCountController taskListStatusCountController = Get.find<GetTaskListStatusCountController>();



  @override
  void initState() {
    super.initState();
    Get.find<GetTaskListController>().getNewTaskList();
    Get.find<GetTaskListStatusCountController>().getNewTaskStatusCount();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            GetBuilder<GetTaskListStatusCountController>(
              builder: (getTaskListStatusCountController) {
                return Visibility(
                  visible: getTaskListStatusCountController.getTaskListStatusCountInProgress == false &&
                      (getTaskListStatusCountController.taskListStatusCountModel.taskCountList?.isNotEmpty ?? false),
                  replacement: LinearProgressIndicator(
                    color: PrimaryColor.color,
                    backgroundColor: Colors.grey,
                  ),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                      getTaskListStatusCountController.taskListStatusCountModel.taskCountList?.length ?? 0,
                      itemBuilder: (context, index) {
                        TaskCount taskCount =
                        getTaskListStatusCountController.taskListStatusCountModel.taskCountList![index];
                        return FittedBox(
                          child: SummaryCard(
                            count: taskCount.sum.toString(),
                            title: taskCount.sId ?? '',
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            ),
            Expanded(
              child: GetBuilder<GetTaskListController>(
                builder: (getTaskListController) {
                  return Visibility(
                    visible: getTaskListController.getTaskLisInProgress == false,
                    replacement: Center(
                      child: CircularProgressIndicator(color: PrimaryColor.color),
                    ),
                    child: RefreshIndicator(
                      color: PrimaryColor.color,
                      onRefresh: getTaskListController.getNewTaskList,
                      child: ListView.builder(
                        itemCount: getTaskListController.taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskItemsCard(
                            task: getTaskListController.taskListModel.taskList![index],
                            onStatusChangeRefresh: () {
                              taskListController.getNewTaskList();
                              taskListStatusCountController.getNewTaskStatusCount();
                            },
                            taskUpdateStatusInProgress: (inProgress) {
                            },
                          );
                        },
                      ),
                    ),
                  );
                }
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
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}