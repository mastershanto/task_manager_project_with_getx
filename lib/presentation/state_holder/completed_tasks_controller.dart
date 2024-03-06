import "package:get/get.dart";
import "../../../data/data_utility/urls.dart";
import "../../../data/models/network_response.dart";
import "../../../data/models/task_list_model.dart";
import "../../../data/services/network_caller.dart";

class CompletedTasksController extends GetxController {
  bool _getCompletedTasksInProgress = false;
  TaskListModel _taskListModel = TaskListModel();


  bool get getCompletedTasksInProgress => _getCompletedTasksInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCompletedTaskList() async {
    bool isSuccess = false;
    _getCompletedTasksInProgress = true;
    update();

    NetworkResponse response =
    await NetworkCaller.getRequest(Urls.getCompleteTaskList);

    _getCompletedTasksInProgress = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      update();
      isSuccess = true;
    }

    update();
    return isSuccess;
  }

}
