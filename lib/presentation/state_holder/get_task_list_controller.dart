import "package:get/get.dart";
import "../../../data/data_utility/urls.dart";
import "../../../data/models/network_response.dart";
import "../../../data/models/task_list_model.dart";
import "../../../data/services/network_caller.dart";

class GetTaskListController extends GetxController {
  bool _getTaskLisInProgress = false;
  TaskListModel _taskListModel = TaskListModel();


  bool get getTaskLisInProgress => _getTaskLisInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getTaskLisInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.getTaskList);
    _getTaskLisInProgress = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      update();
      isSuccess = true;
    }

    update();
    return isSuccess;
  }

}
