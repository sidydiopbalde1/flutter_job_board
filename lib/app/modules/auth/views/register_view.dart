import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Créer un compte',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Inscrivez-vous',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Créez votre compte pour commencer',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: nameController,
                  labelText: 'Nom complet',
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.emailController,
                  labelText: 'Email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.passwordController,
                  labelText: 'Mot de passe',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: confirmPasswordController,
                  labelText: 'Confirmer le mot de passe',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                Obx(() => AnimatedOpacity(
                      opacity: controller.errorMessage.value.isNotEmpty ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        controller.errorMessage.value,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.red,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    )),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'S\'inscrire',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Vous avez déjà un compte ? ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed('/login'),
                      child: Text(
                        'Connectez-vous',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.deepPurple),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }

  void _registerUser() {
    // Reset the error message
    controller.errorMessage.value = '';

    // Validate fields
    if (nameController.text.isEmpty) {
      controller.errorMessage.value = 'Veuillez entrer votre nom complet';
      return;
    }

    if (controller.emailController.text.isEmpty ||
        !GetUtils.isEmail(controller.emailController.text)) {
      controller.errorMessage.value = 'Veuillez entrer un email valide';
      return;
    }

    if (controller.passwordController.text.isEmpty) {
      controller.errorMessage.value = 'Veuillez entrer un mot de passe';
      return;
    }

    if (controller.passwordController.text != confirmPasswordController.text) {
      controller.errorMessage.value = 'Les mots de passe ne correspondent pas';
      return;
    }

    // TODO: Implement the registration method from the controller
    // Example: controller.register()
  }
}
