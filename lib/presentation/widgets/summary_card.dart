import 'package:flutter/material.dart';



class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,required this.count,required this.title
  });

  final String count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(count.toString(),style:const TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.w900)),
            Text(title),
          ],
        ),
      ),
    );
  }
}