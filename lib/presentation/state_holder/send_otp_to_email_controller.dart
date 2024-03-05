import 'package:get/get.dart';
import 'package:task_manager_project_with_getx/data/models/network_response.dart';
import 'package:task_manager_project_with_getx/data/services/network_caller.dart';

import '../../data/data_utility/urls.dart';

class SendOtpToEmailController extends GetxController {
  bool _sendOtpToEmailInProgress = false;
  String _errorMessage = "";
  bool _isSendingOtpCompleted=false;


  bool get sendOtpToEmailInProgress=>_sendOtpToEmailInProgress;
  String get errorMessage => _errorMessage;
  bool get isSendingOtpCompleted=>_isSendingOtpCompleted;

  Future<bool> sendOtpToEmail(String email) async {
    _sendOtpToEmailInProgress=true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(Urls.verifyEmailAddress(email),);

    _sendOtpToEmailInProgress = false;
    if (response.isSuccess) {
     _isSendingOtpCompleted=response.statusCode==200;
      update();
      return true;
    } else {
      if (response.statusCode == 401) {
        _errorMessage= "Email or Password is incorrect!";
      } else {
        _errorMessage= "Login failed! Please try again.";

      }
      update();
      return false;
    }

  }

}
