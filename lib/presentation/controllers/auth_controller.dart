import 'package:flame_game/core/services/auth_service.dart';
import 'package:flame_game/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

import '../../data/source/local_storage.dart';
import '../../domain/entities/player.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  AuthService authService = AuthService();
  static final localStorage = LocalStorage();
  RxBool isRegisterLoading = false.obs;
  RxBool isLoginLoading = false.obs;
  AuthController({authService});
  Future<bool> signUp(
      {required String email,
      required String password,
      required String gender}) async {
    isRegisterLoading.value = true;

    try {
      await authService.signUpWithEmailAndPassword(email, password);
      Get.snackbar(
        'Félicitations',
        'Ton compte a été créé',
        colorText: Colors.white,
        backgroundColor: AppColors.secondaryColor.withOpacity(0.6),
      );
      Get.toNamed(AppRoutes.homePage);
      return true;
    } on AuthException catch (e) {
      // throw Exception(e.message);
      if (e.statusCode == "400") {
        Get.snackbar(
          'Erreur',
          'Cet joueur existe déjà',
          colorText: Colors.white,
          backgroundColor: AppColors.primaryColor,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Oh oh',
        'Une erreur s\'est produite',
        colorText: Colors.white,
        backgroundColor: AppColors.primaryColor.withOpacity(0.6),
      );
    }
    isRegisterLoading.value = false;

    return false;
  }

  Future signIn({required String email, required String password}) async {
    isLoginLoading.value = true;

    try {
      await authService.signInWithEmailAndPassword(email, password);
      Get.snackbar(
        'Félicitations',
        'Tu es connecté',
        colorText: Colors.white,
        backgroundColor: AppColors.secondaryColor,
      );
      localStorage.setUserLoggedIn(true);
      Get.toNamed(AppRoutes.homePage);
    } on AuthException catch (e) {
      if (e.statusCode == "400") {
        Get.snackbar(
          'Erreur',
          'Cet joueur n\'existe pas',
          colorText: Colors.white,
          backgroundColor: AppColors.primaryColor.withOpacity(0.6),
        );
      } else {
        Get.snackbar(
          'Erreur',
          e.message,
          colorText: Colors.white,
          backgroundColor: AppColors.primaryColor.withOpacity(0.6),
        );
      }
    }
    isLoginLoading.value = false;
  }

  Future signOut() async {
    await authService.signOut();
    Get.offAllNamed(AppRoutes.introPage);
  }

  continueAsGuest() async {
    final existingGuest = await localStorage
        .rawQuery("SELECT * FROM players WHERE name = 'Guest'");
    if (existingGuest.isEmpty) {
      try {
        await localStorage.insertData(
          "players",
          Player(id: 1, userName: 'Guest').toJson(),
        );
        await localStorage.insertData('stats', {
          'player_id': 1,
          'score': 0,
          'level': 0,
        });
        await localStorage.setUserLoggedIn(true);
        Get.toNamed(AppRoutes.homePage);
      } catch (e) {
        print(e);
      }
    } else {
      Get.toNamed(AppRoutes.homePage);
    }
  }

  Future<Player> getCurrentPlayer() async {
    final res = (await localStorage.getData('players')).first;
    final currentPlayer = Player.fromJson(res);
    return currentPlayer;
  }
}
