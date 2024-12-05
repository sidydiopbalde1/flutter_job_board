import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  // Champs de texte pour les e-mails et les mots de passe
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observables pour l'état de chargement et les erreurs
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Instance de FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Connexion utilisateur
  Future<void> login() async {
    // Vérification des champs vides
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      errorMessage.value = 'Veuillez remplir tous les champs';
      return;
    }

    try {
      isLoading.value = true;

      // Connexion via Firebase
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Redirection après une connexion réussie
      Get.offAllNamed('/jobs');
    } on FirebaseAuthException catch (e) {
      // Gestion des erreurs spécifiques Firebase
      if (e.code == 'user-not-found') {
        errorMessage.value = 'Aucun utilisateur trouvé pour cet e-mail.';
      } else if (e.code == 'wrong-password') {
        errorMessage.value = 'Mot de passe incorrect.';
      } else {
        errorMessage.value = 'Erreur: ${e.message}';
      }
    } catch (e) {
      errorMessage.value = 'Une erreur inattendue s\'est produite.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Redirection vers la page d'inscription
  void navigateToRegister() {
    Get.toNamed('/register');
  }

  /// Libération des ressources lorsque le contrôleur est détruit
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
