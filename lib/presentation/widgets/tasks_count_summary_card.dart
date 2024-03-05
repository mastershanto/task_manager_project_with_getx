import 'package:flutter/material.dart';

class TaskCountsSummaryCard extends StatelessWidget {
  final String summaryCount;
  final String summaryTitle;

  const TaskCountsSummaryCard({
    super.key,
    required this.summaryCount,
    required this.summaryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
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
