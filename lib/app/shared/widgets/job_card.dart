import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/job_model.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback? onTap;

  const JobCard({
    Key? key, 
    required this.job, 
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(job.companyLogoUrl),
        ),
        title: Text(
          job.title, 
          style: Get.textTheme.titleMedium
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.companyName),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: Text(job.type.toString().split('.').last),
                  backgroundColor: Colors.blue.shade50,
                ),
                Chip(
                  label: Text('${job.salary.toString()}€'),
                  backgroundColor: Colors.green.shade50,
                )
              ],
            )
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}