// modules/profile/controllers/profile_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UserProfile {
  final String name;
  final String email;
  final String? profilePicture;
  final List<String> skills;

  UserProfile({
    required this.name,
    required this.email,
    this.profilePicture,
    this.skills = const [],
  });
}

class ProfileController extends GetxController {
  final Rx<UserProfile> userProfile = UserProfile(
    name: 'Jean Dupont', 
    email: 'jean.dupont@example.com',
    skills: ['Flutter', 'Dart', 'Firebase'],
  ).obs;

  final skillController = TextEditingController();

  void addSkill() {
    if (skillController.text.isNotEmpty) {
      userProfile.update((val) {
        val!.skills.add(skillController.text);
      });
      skillController.clear();
    }
  }

  void removeSkill(String skill) {
    userProfile.update((val) {
      val!.skills.remove(skill);
    });
  }

  @override
  void onClose() {
    skillController.dispose();
    super.onClose();
  }
}