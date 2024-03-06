import 'package:get/get.dart';
import '../../data/data_utility/urls.dart';
import '../../data/models/network_response.dart';
import '../../data/models/user_model.dart';
import '../../data/services/network_caller.dart';
import 'authentication_controller.dart';

class UpdateProfileController extends GetxController {
  bool _updateProfileInProgress = false;
  String _errorMessage = "";

  bool get updateProfileInProgress => _updateProfileInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> updateProfile(
      {required Map<String, dynamic> inputData, String? password}) async {
    _updateProfileInProgress=true;
    update();

    if (password!="") {
      inputData["password"] = password;
    }
    final NetworkResponse response =
    await NetworkCaller.postRequest(Urls.profileUpdate, body: inputData);
    _updateProfileInProgress = false;
    if (response.isSuccess) {
      await AuthenticationController.updateUserInformation(UserModel(
        email:inputData["email"],
        firstName: inputData["firstName"],
        lastName: inputData["lastName"],
        mobile: inputData["mobile"],
        photo: inputData["photo"] ?? AuthenticationController.user?.photo,
      ));
      update();
      return true;
    } else {
      if (response.statusCode == 401) {
        _errorMessage= "Your login time expired! please, login again.";
      } else {
        _errorMessage= "Action Failed! Please, try again.";

      }
      update();
      return false;
    }

  }

}
