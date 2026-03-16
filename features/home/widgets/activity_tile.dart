import 'package:flutter/material.dart';

class ActivityTile extends StatelessWidget {
  final String title;
  final String time;

  const ActivityTile({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.check)),
        title: Text(title),
        subtitle: Text(time),
        trailing: const Icon(Icons.more_horiz),
      ),
    );
  }
}
