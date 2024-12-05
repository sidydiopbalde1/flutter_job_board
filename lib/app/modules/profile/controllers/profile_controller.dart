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
    this.profilePicture ='https://res.cloudinary.com/di50em335/image/upload/v1730225327/uploads/wyzi32fuli00fheydqga.jpg',
    this.skills = const [],
  });
}

class ProfileController extends GetxController {
  final Rx<UserProfile> userProfile = UserProfile(
    name: 'Balde Sidy Diop', 
    email: 'newsdb191@examgmail.com',
    skills: ['Flutter', 'Dart', 'Firebase','ReactJs','Angular','Laravel'],
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