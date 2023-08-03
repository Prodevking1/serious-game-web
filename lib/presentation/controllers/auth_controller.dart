import 'package:flame_game/core/services/auth_service.dart';
import 'package:flame_game/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

import '../routes/router.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  Future signUp(
      {required String email,
      required String password,
      required String gender}) async {
    try {
      await _authService.signUpWithEmailAndPassword(email, password);
      Get.snackbar(
        'Félicitations',
        'Ton compte a été créé',
        colorText: Colors.white,
        backgroundColor: AppColors.secondaryColor,
      );
      Get.toNamed(AppRouter.homePage);
    } on AuthException catch (e) {
      if (e.statusCode == "400") {
        Get.snackbar(
          'Erreur',
          'Cet joueur existe déjà',
          colorText: Colors.white,
          backgroundColor: AppColors.primaryColor,
        );
      } else {
        Get.snackbar(
          'Erreur',
          e.message,
          colorText: Colors.white,
          backgroundColor: AppColors.primaryColor,
        );
      }
    }
  }

  Future signIn({required String email, required String password}) async {
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      Get.snackbar(
        'Félicitations',
        'Tu es connecté',
        colorText: Colors.white,
        backgroundColor: AppColors.secondaryColor,
      );
      Get.toNamed(AppRouter.homePage);
    } on AuthException catch (e) {
      if (e.statusCode == "400") {
        Get.snackbar(
          'Erreur',
          'Cet joueur n\'existe pas',
          colorText: Colors.white,
          backgroundColor: AppColors.primaryColor,
        );
      } else {
        Get.snackbar(
          'Erreur',
          e.message,
          colorText: Colors.white,
          backgroundColor: AppColors.primaryColor,
        );
      }
    }
  }

  Future signOut() async {
    await _authService.signOut();
    Get.offAllNamed(AppRouter.introPage);
  }
}
