import 'package:get/get.dart';
import '../../data/data_utility/urls.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';

class SignUpController extends GetxController {
  bool _signUpInProgress = false;
  String _errorMessage = "";

  bool get signUpInProgress => _signUpInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> signUp(
      {required Map<String, dynamic> inputData, String? password}) async {
    _signUpInProgress=true;
    update();

    if (password!="") {
      inputData["password"] = password;
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
        Urls.registration,
        body:inputData
    );
    _signUpInProgress = false;
    if (response.isSuccess) {

      update();
      return true;
    } else {
      if (response.statusCode == 401) {
        _errorMessage= "401: Something went wrong!";
      } else {
        _errorMessage= "Account creation failed! Please try again.";
      }
      update();
      return false;
    }

  }

}
