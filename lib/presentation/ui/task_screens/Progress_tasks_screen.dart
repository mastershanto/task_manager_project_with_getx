import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/progress_tasks_controller.dart';
import '../../presentation_utility/style.dart';
import '../../widgets/profile_summary_card.dart';
import '../../widgets/task_items_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final ProgressTasksController _progressTasksController = Get.find<ProgressTasksController>();

  @override
  void initState() {
    super.initState();
   _progressTasksController.getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            Expanded(
              child: GetBuilder<ProgressTasksController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.getProgressTasksInProgress == false,
                    replacement: Center(
                      child: CircularProgressIndicator(color: PrimaryColor.color),
                    ),
                    child: RefreshIndicator(
                      color: PrimaryColor.color,
                      onRefresh: controller.getProgressTaskList,
                      child: ListView.builder(
                        itemCount: controller.taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskItemsCard(
                            statusColor: Colors.green,
                            task: controller.taskListModel.taskList![index],
                            onStatusChangeRefresh: () {
                              controller.getProgressTaskList();
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
            )
          ],
        ),
      ),
    );
  }
}
