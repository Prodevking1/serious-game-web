import 'package:flame_game/core/services/auth_service.dart';
import 'package:flame_game/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

import '../../domain/entities/player.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  AuthService authService = AuthService();
  RxBool isRegisterLoading = false.obs;
  RxBool isLoginLoading = false.obs;
  AuthController({authService});

  SupabaseClient supabaseClient = Get.find();

  Future<bool> signUp({
    required String email,
    required String password,
    required String gender,
  }) async {
    isRegisterLoading.value = true;

    try {
      final res = await authService.signUpWithEmailAndPassword(email, password);
      if (res.user != null) {
        await supabaseClient.from('players').insert({
          'id': res.user!.id,
          'name': email.split('@')[0],
          'gender': gender,
        });
      }

      isRegisterLoading.value = false;

      Get.snackbar(
        'Félicitations',
        'Ton compte a été créé',
        colorText: Colors.white,
        backgroundColor: AppColors.secondaryColor.withOpacity(0.6),
      );

      Get.toNamed(AppRoutes.homePage);
      isLoginLoading.value = false;
      return true;
    } on AuthException catch (e) {
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
      throw Exception(e);
    }

    return false;
  }

  Future signIn({required String email, required String password}) async {
    isLoginLoading.value = true;

    try {
      final response =
          await authService.signInWithEmailAndPassword(email, password);
      if (response.user != null) {
        await savePlayerData(Player(
          id: response.user!.id,
          userName: email.split('@')[0],
        ));
        await saveStatsData({
          'player_id': 1,
          'score': 0,
          'level': 0,
        });
        saveUserLoggedIn(true);
      }

      isLoginLoading.value = false;

      Get.snackbar(
        'Félicitations',
        'Tu es connecté',
        colorText: Colors.white,
        backgroundColor: AppColors.secondaryColor,
      );

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
      rethrow;
    }
  }

  Future signOut() async {
    await authService.signOut();
    Get.offAllNamed(AppRoutes.introPage);
  }

  continueAsGuest() async {
    final existingGuest = await getPlayerDataByName('Guest');
    if (existingGuest == null) {
      try {
        await savePlayerData(Player(
          id: "1",
          userName: 'Guest',
          gender: 'F',
          totalScore: 0,
        ));
        await saveStatsData({
          'player_id': 1,
          'score': 0,
          'level': 0,
        });
        saveUserLoggedIn(true);
        Get.toNamed(AppRoutes.homePage);
      } catch (e) {
        print(e);
      }
    } else {
      Get.toNamed(AppRoutes.homePage);
    }
  }

  Future getCurrentPlayer() async {
    try {
      final res = await getPlayerData();
      print(res);
      return res?.first;
    } catch (e) {
      rethrow;
    }
  }

  // Fonctions pour gérer la sauvegarde des données
  Future<void> savePlayerData(Player player) async {
    // Implémentez la sauvegarde de Player directement ici
  }

  Future<void> saveStatsData(Map<String, dynamic> stats) async {
    // Implémentez la sauvegarde de Stats directement ici
  }

  Future<void> saveUserLoggedIn(bool value) async {
    // Implémentez la sauvegarde de l'état de connexion directement ici
  }

  Future<List<Map<String, dynamic>>?> getPlayerData() async {
    // Implémentez la récupération de données du joueur directement ici
    return null;
  }

  Future<List<Map<String, dynamic>>?> getPlayerDataByName(String name) async {
    // Implémentez la récupération de données du joueur par nom directement ici
    return null;
  }
}
