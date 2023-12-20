import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String summaryCount;
  final String summaryTitle;

  const SummaryCard({
    super.key,
    required this.summaryCount,
    required this.summaryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              summaryCount.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              summaryTitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
