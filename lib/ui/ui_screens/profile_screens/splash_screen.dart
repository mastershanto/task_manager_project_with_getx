import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_project_with_getx/ui/controllers/auth_controller.dart';

import '../../widgets/background_image.dart';
import '../task_screens/main_bottom_nev_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void splashScreenTimeOut() async {
    bool isLoggedIn = await AuthController.checkUserAuthState();

    Future.delayed(const Duration(seconds: 2)).then(
          (value) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
          isLoggedIn ? const MainBottomNavScreen() : const LoginScreen(),
        ),
            (route) => false,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    splashScreenTimeOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        showBottomCircularLoading: true,
        child: Center(
          child: SvgPicture.asset(
            'assets/logo.svg',
            width: 120,
          ),
        ),
      ),
    );
  }
}
