// modules/profile/views/profile_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Profil'),
      ),
      body: Obx(() {
        final profile = controller.userProfile.value;
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: profile.profilePicture != null
                        ? NetworkImage(profile.profilePicture!)
                        : null,
                    child: profile.profilePicture == null 
                        ? Icon(Icons.person, size: 60) 
                        : null,
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    profile.name, 
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Center(
                  child: Text(
                    profile.email,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Compétences',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.skillController,
                        decoration: InputDecoration(
                          hintText: 'Ajouter une compétence',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: controller.addSkill,
                    )
                  ],
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: profile.skills.map((skill) => Chip(
                    label: Text(skill),
                    onDeleted: () => controller.removeSkill(skill),
                  )).toList(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}