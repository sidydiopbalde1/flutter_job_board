import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/routes/app_pages.dart';

void main() async {
  // S'assurer que les Widgets sont initialisés
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser Firebase
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      title: "Job Application",
      initialRoute: AppRoutes.INITIAL,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
