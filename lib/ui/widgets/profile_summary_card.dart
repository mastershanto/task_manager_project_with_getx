import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:task_manager_project_with_getx/ui/controllers/auth_controller.dart';

import '../../style/style.dart';
import '../ui_screens/profile_screens/login_screen.dart';
import '../ui_screens/profile_screens/update_profile_screen.dart';

class ProfileSummaryCard extends StatefulWidget {
  final bool onTapStatus;

  const ProfileSummaryCard({
    super.key,
    this.onTapStatus = true,
  });

  @override
  State<ProfileSummaryCard> createState() => _ProfileSummaryCardState();
}

class _ProfileSummaryCardState extends State<ProfileSummaryCard> {
  String? imageData = AuthController.user?.photo!.split("data:image/png;base64")[0];
  String imageFormat = AuthController.user?.photo ?? '';

  @override
  Widget build(BuildContext context) {
    if (imageFormat.startsWith('data:image')) {
      imageFormat =
          imageFormat.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
    }
    Uint8List imageInBytes = const Base64Decoder().convert(imageFormat);
    return ListTile(
      onTap: () {
        if (widget.onTapStatus == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen()),
          );
        }
      },
      leading: Visibility(
        visible: imageInBytes.isNotEmpty,
        replacement: const CircleAvatar(
          backgroundColor: Colors.lightGreen,
          child: Icon(Icons.account_circle_outlined),
        ),
        child: CircleAvatar(
          backgroundImage: Image.memory(
            imageInBytes,
            fit: BoxFit.cover,
          ).image,
          backgroundColor: Colors.lightGreen,
        ),
      ),
      title: Text(
        userFullName,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        AuthController.user?.email ?? '',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      trailing: IconButton(
        onPressed: () async {
          await AuthController.clearUserAuthState();
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
                  (route) => false,
            );
          }
        },
        icon: const Icon(Icons.logout,color: Colors.red,),
      ),
      tileColor: PrimaryColor.color,
    );
  }

  String get userFullName {
    return '${AuthController.user?.firstName ?? ''} ${AuthController.user?.lastName ?? ''}';
  }
}
