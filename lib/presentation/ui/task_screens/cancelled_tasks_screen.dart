import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/cancelled_tasks_controller.dart';

import '../../presentation_utility/style.dart';
import '../../widgets/profile_summary_card.dart';
import '../../widgets/task_items_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  final CancelledTasksController _cancelledTasksController=Get.find<CancelledTasksController>();

  @override
  void initState() {
    super.initState();
    _cancelledTasksController.getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            Expanded(
              child: GetBuilder<CancelledTasksController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.getCancelledTasksInProgress == false,
                    replacement: Center(
                      child: CircularProgressIndicator(color: PrimaryColor.color),
                    ),
                    child: RefreshIndicator(
                      color: PrimaryColor.color,
                      onRefresh: controller.getCancelledTaskList,
                      child: ListView.builder(
                        itemCount: controller.taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskItemsCard(
                            statusColor: Colors.redAccent,
                            task: controller.taskListModel.taskList![index],
                            onStatusChangeRefresh: () {
                              controller.getCancelledTaskList();
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
