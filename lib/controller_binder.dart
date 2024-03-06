import 'package:get/get.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/cancelled_tasks_controller.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/completed_tasks_controller.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/get_task_list_status_count_controller.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/otp_verification_controller.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/progress_tasks_controller.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/send_otp_to_email_controller.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/set_password_controller.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/sign_up_controller.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/update_profile_controller.dart';

import 'presentation/state_holder/authentication_controller.dart';
import 'presentation/state_holder/get_task_list_controller.dart';
import 'presentation/state_holder/login_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthenticationController());
    Get.put(LoginController());
    Get.put(GetTaskListController());
    Get.put(SendOtpToEmailController());
    Get.put(OtpVerificationController());
    Get.put(SetPasswordController());
    Get.put(GetTaskListController());
    Get.put(GetTaskListStatusCountController());
    Get.put(UpdateProfileController());
    Get.put(SignUpController());
    Get.put(ProgressTasksController());
    Get.put(CompletedTasksController());
    Get.put(CancelledTasksController());
  }
}
