import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presentation_utility/style.dart';
import '../../state_holder/completed_tasks_controller.dart';
import '../../widgets/profile_summary_card.dart';
import '../../widgets/task_items_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}


class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  final CompletedTasksController _completedTasksController=Get.find<CompletedTasksController>();

  @override
  void initState() {
    super.initState();
    _completedTasksController.getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            Expanded(
              child: GetBuilder<CompletedTasksController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.getCompletedTasksInProgress == false,
                    replacement: Center(
                      child: CircularProgressIndicator(color: PrimaryColor.color),
                    ),
                    child: RefreshIndicator(
                      color: PrimaryColor.color,
                      onRefresh: controller.getCompletedTaskList,
                      child: ListView.builder(
                        itemCount: controller.taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskItemsCard(
                            statusColor: PrimaryColor.color,
                            task: controller.taskListModel.taskList![index],
                            onStatusChangeRefresh: () {
                              controller.getCompletedTaskList();
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
