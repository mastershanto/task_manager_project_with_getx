import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_with_getx/presentation/state_holder/send_otp_to_email_controller.dart';
import '../../presentation_utility/input_validations.dart';
import '../../presentation_utility/style.dart';
import '../../widgets/background.dart';
import 'otp_verification_screen.dart';

class SendOtpToEmailScreen extends StatefulWidget {
  const SendOtpToEmailScreen({super.key});

  @override
  State<SendOtpToEmailScreen> createState() => _SendOtpToEmailScreenState();
}

class _SendOtpToEmailScreenState extends State<SendOtpToEmailScreen> {
  final TextEditingController _emailInputTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SendOtpToEmailController _emailVerificationController=Get.find<SendOtpToEmailController>();

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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Email Address",
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    Text(
                      "A 6 digit verification pin will be send to your email address",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailInputTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      validator: FormValidation.emailValidation,
                    ),
                    const SizedBox(height: 8),
                    GetBuilder<SendOtpToEmailController>(
                      builder: (controller) {
                        return Visibility(
                          visible: controller.sendOtpToEmailInProgress==false,
                          replacement: Center(
                            child: CircularProgressIndicator(
                              color: PrimaryColor.color,
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: verifyEmailAddress,
                                child:
                                const Icon(Icons.arrow_circle_right_outlined,color: Colors.white,)),
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
                            Navigator.pop(context);
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
      ),
    );
  }

  Future<void> verifyEmailAddress() async {
          if (!_formKey.currentState!.validate()) {
        return;
      }

      final bool result=await _emailVerificationController.sendOtpToEmail(_emailInputTEController.text.trim());

      if(result){
        Get.offAll(()=> OtpVerificationScreen(email: _emailInputTEController.text.trim()));
      }else{
        Get.showSnackbar(GetSnackBar(
          title: "Send Otp Failed",
          message: _emailVerificationController.errorMessage,
        ));
      }
  }
}
