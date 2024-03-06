import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/otp_verification_controller.dart';
import '../../presentation_utility/style.dart';
import '../../widgets/background.dart';
import 'login_screen.dart';
import 'set_password_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final OtpVerificationController _otpVerificationController=Get.find<OtpVerificationController>();
  Map<String, String> pinCode = {'otp': ''};
  bool pinVerifyInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 60,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("PIN Verification",
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  Text(
                    "A 6 digit verification pin will be send to your email address",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: customPinTheme(),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    onCompleted: (v) {},
                    onChanged: (value) {
                      pinCode['otp'] = value;
                    },
                  ),
                  const SizedBox(height: 8),
                  GetBuilder<OtpVerificationController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.otpVerificationInProgress == false,
                        replacement: Center(
                            child: CircularProgressIndicator(
                              color: PrimaryColor.color,
                            )),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: verifyPinCode,
                            child: const Text("Verify",style:TextStyle(color: Colors.white,)),
                          ),
                        ),
                      );
                    }
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offAll(()=>const LoginScreen());
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(color: PrimaryColor.color),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyPinCode() async {
    if (pinCode['otp'] != null && pinCode['otp']?.length == 6) {

      final bool result = await _otpVerificationController.verifyOtp(widget.email, pinCode['otp']!);

      if (result) {
        Get.offAll(()=>SetPasswordScreen( email:widget.email, pin: pinCode['otp']!));
      } else{
        Get.showSnackbar(GetSnackBar(
          title: "Otp Verification failed",
          message: _otpVerificationController.errorMessage,
        ));
      }
    }
  }
}
