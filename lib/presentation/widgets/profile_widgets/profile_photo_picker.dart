
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../presentation_utility/style.dart';

class ProfilePhotoPicker extends StatefulWidget{
  const ProfilePhotoPicker({super.key});

  @override
  State<ProfilePhotoPicker> createState() => _ProfilePhotoPickerState();
}

class _ProfilePhotoPickerState extends State<ProfilePhotoPicker> {
  XFile? photo;

  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.symmetric(vertical: 18.0),
     child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             TextButton(
               onPressed: () async {
                 final XFile? image = await ImagePicker().pickImage(
                   source: ImageSource.gallery,
                   imageQuality: 50,
                 );
                 if (image != null) {
                   photo = image;
                   Get.back();
                 }
               },
               child: Column(
                 children: [
                   Icon(
                     Icons.image,
                     color: PrimaryColor.color,
                     size: 34,
                   ),
                   const Text(
                     "Gallery",
                     style: TextStyle(
                       color: Colors.grey,
                     ),
                   ),
                 ],
               ),
             ),
             const SizedBox(width: 12),
             TextButton(
               onPressed: () async {
                 final XFile? image = await ImagePicker().pickImage(
                   source: ImageSource.camera,
                   imageQuality: 50,
                 );
                 if (image != null) {
                   photo = image;
                   Get.back();

                 }
               },
               child: Column(
                 children: [
                   Icon(
                     Icons.camera,
                     color: PrimaryColor.color,
                     size: 34,
                   ),
                   const Text(
                     "Camera",
                     style: TextStyle(
                       color: Colors.grey,
                     ),
                   ),
                 ],
               ),
             ),
           ],
         ),
       ],
     ),
   );
  }
}
