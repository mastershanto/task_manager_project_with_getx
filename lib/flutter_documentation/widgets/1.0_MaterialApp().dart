import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
   return AppBar(
     backgroundColor: Colors.lightGreen,
     centerTitle: true,
     title: const Text('Home'),
     leading: const Icon(
       Icons.add_business,
       color: Colors.black,
       size: 40,
     ),
   );
  }
}