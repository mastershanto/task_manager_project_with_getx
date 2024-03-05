import 'package:get/get.dart';
import '../../data/data_utility/urls.dart';
import '../../data/models/network_response.dart';
import '../../data/models/user_model.dart';
import '../../data/services/network_caller.dart';
import 'authentication_controller.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;
  String _errorMessage = "";

  bool get loginInProgress => _loginInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _loginInProgress=true;
    update();

    final NetworkResponse response = await NetworkCaller.postRequest(Urls.login,
        body: {"email": email, "password": password},isLogin: true);

    _loginInProgress = false;

    if (response.isSuccess) {
      await AuthenticationController.saveUserInformation(
        response.jsonResponse["token"],
        UserModel.fromJson(response.jsonResponse['data']),
      );
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
