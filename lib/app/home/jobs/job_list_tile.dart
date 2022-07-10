// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';

/// This class servers to build the UI for the list on Jobs page.
class JobListTile extends StatelessWidget {
  const JobListTile({Key? key, required this.job, required this.onTap})
      : super(key: key);

  final Job? job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job!.name),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
