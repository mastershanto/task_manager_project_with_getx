import "package:get/get.dart";
import "package:task_manager_project_with_getx/data/models/task_list_status_count_model.dart";
import "../../../data/data_utility/urls.dart";
import "../../../data/models/network_response.dart";
import "../../../data/models/task_list_model.dart";
import "../../../data/services/network_caller.dart";

class GetTaskListStatusCountController extends GetxController {
  bool _getTaskListStatusCountInProgress = false;
  TaskListStatusCountModel _taskListStatusCountModel =
      TaskListStatusCountModel();

  bool get getTaskListStatusCountInProgress => _getTaskListStatusCountInProgress;
  TaskListStatusCountModel get taskListStatusCountModel =>
      _taskListStatusCountModel;

  Future<bool> getNewTaskStatusCount() async {
    bool isSuccess = false;
    _getTaskListStatusCountInProgress = true;

    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getTaskStatusCount);
    _getTaskListStatusCountInProgress = false;
    if (response.isSuccess) {
      _taskListStatusCountModel =
          TaskListStatusCountModel.fromJson(response.jsonResponse);
      update();
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
