import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presentation_utility/input_validations.dart';
import '../../presentation_utility/style.dart';
import '../../state_holder/login_controller.dart';
import '../../widgets/background.dart';
import '../task_screens/main_bottom_nev_screen.dart';
import 'send_otp_to_email_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailInputTEController = TextEditingController();
  final TextEditingController _passwordInputTEController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final LoginController _loginController=Get.find<LoginController>();

  bool loginInProgress = false;

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
                    const SizedBox(height: 100),
                    Text("Get Started With",
                        style: Theme.of(context).textTheme.bodyLarge),
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
                    TextFormField(
                      controller: _passwordInputTEController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                      validator: FormValidation.inputValidation,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<LoginController>(
                        builder: (loginController) {
                          return Visibility(
                            visible: loginController.loginInProgress == false,
                            replacement: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Center(
                                  child: CircularProgressIndicator(
                                    color: PrimaryColor.color,
                                  )),
                            ),
                            child: ElevatedButton(
                                onPressed: _login,
                                child:
                                const Icon(Icons.arrow_circle_right_outlined,color: Colors.white,)),
                          );
                        }
                      ),
                    ),
                    const SizedBox(height: 48),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.to(()=> const SendOtpToEmailScreen());
                        },
                        child: const Text(
                          "Forget Password ?",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have account?",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(()=>const SignUpScreen());
                          },
                          child: Text(
                            "Sign up",
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

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final bool result=await _loginController.login(_emailInputTEController.text.trim(), _passwordInputTEController.text);

    if(result){
      Get.offAll(()=>const MainBottomNavScreen());
    }else{
      Get.showSnackbar(GetSnackBar(
        title: "Login failed",
        message: _loginController.errorMessage,
      ));
    }


  }

  @override
  void dispose() {
    _emailInputTEController.dispose();
    _passwordInputTEController.dispose();
    super.dispose();
  }
}