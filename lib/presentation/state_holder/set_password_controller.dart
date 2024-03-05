import 'package:get/get.dart';
import '../../data/data_utility/urls.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';

class SetPasswordController extends GetxController {
  bool _setPasswordInProgress = false;
  String _errorMessage = "";
  bool _isSetPasswordCompleted=false;

  bool get setPasswordInProgress => _setPasswordInProgress;
  String get errorMessage => _errorMessage;
  bool get isSetPasswordCompleted=>_isSetPasswordCompleted;

  Future<bool> setPassword(String email, String otp, String password) async {
    _setPasswordInProgress=true;
    update();

    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.setNewPassword,
      body: {
        "email": email,
        "OTP": otp,
        "password": password,
      },
    );
    _setPasswordInProgress = false;

    if (response.isSuccess) {
      _isSetPasswordCompleted=response.statusCode==200;
      update();
      return true;
    } else {
      if (response.statusCode == 401) {
        _errorMessage= "Password setup failed! Try again.";
      } else {
        _errorMessage= "Enter your valid password.";

      }
      update();
      return false;
    }

  }

}
