import "package:get/get.dart";
import "../../../data/data_utility/urls.dart";
import "../../../data/models/network_response.dart";
import "../../../data/models/task_list_model.dart";
import "../../../data/services/network_caller.dart";

class CancelledTasksController extends GetxController {
  bool _getCancelledTasksInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCancelledTasksInProgress => _getCancelledTasksInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCancelledTaskList() async {
    bool isSuccess = false;
    _getCancelledTasksInProgress = true;
    update();

    NetworkResponse response =
    await NetworkCaller.getRequest(Urls.getCancelTaskList);

    _getCancelledTasksInProgress = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      update();
      isSuccess = true;
    }

    update();
    return isSuccess;
  }

}
