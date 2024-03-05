import 'package:get/get.dart';
import '../../data/data_utility/urls.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';

class OtpVerificationController extends GetxController {
  bool _otpVerificationInProgress = false;
  String _errorMessage = "";
  bool _isOtpVerificationCompleted=false;

  bool get otpVerificationInProgress => _otpVerificationInProgress;
  String get errorMessage => _errorMessage;
  bool get isOtpVerificationCompleted=>_isOtpVerificationCompleted;

  Future<bool> verifyOtp(String email, String otp) async {
    _otpVerificationInProgress=true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(Urls.verifyPinCode(email, otp));

    _otpVerificationInProgress = false;

    if (response.isSuccess && response.jsonResponse['status'] != 'fail') {
      _isOtpVerificationCompleted=response.statusCode==200;
      update();
      return true;
    } else {
      if (response.statusCode == 401) {
        _errorMessage= "Otp verification failed";
      } else {
        _errorMessage= "Enter the valid OTP!";

      }
      update();
      return false;
    }

  }

}
