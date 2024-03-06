import "package:get/get.dart";
import "../../../data/data_utility/urls.dart";
import "../../../data/models/network_response.dart";
import "../../../data/models/task_list_model.dart";
import "../../../data/services/network_caller.dart";

class ProgressTasksController extends GetxController {
  bool _getProgressTasksInProgress = false;
  TaskListModel _taskListModel = TaskListModel();


  bool get getProgressTasksInProgress => _getProgressTasksInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getProgressTaskList() async {
    bool isSuccess = false;
    _getProgressTasksInProgress = true;
    update();

    NetworkResponse response =
    await NetworkCaller.getRequest(Urls.getProgressTaskList);

    _getProgressTasksInProgress = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      update();
      isSuccess = true;
    }

    update();
    return isSuccess;
  }

}
