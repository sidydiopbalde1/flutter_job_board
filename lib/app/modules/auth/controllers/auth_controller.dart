import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      errorMessage.value = 'Veuillez remplir tous les champs';
      return;
    }

    try {
      isLoading.value = true;
      // Logique d'authentification (à remplacer par votre implémentation)
      await Future.delayed(Duration(seconds: 2)); // Simulation de l'appel API
      
      // Redirection après connexion réussie
      Get.offAllNamed('/jobs');
    } catch (e) {
      errorMessage.value = 'Erreur de connexion. Réessayez.';
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToRegister() {
    Get.toNamed('/register');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}