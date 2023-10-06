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

  SupabaseClient supabaseClient = Get.find();
  Future<bool> signUp(
      {required String email,
      required String password,
      required String gender}) async {
    isRegisterLoading.value = true;

    try {
      final res = await authService.signUpWithEmailAndPassword(email, password);
      if (res.user != null) {
        await supabaseClient.from('players').insert({
          'id': res.user!.id,
          'name': email.split('@')[0],
          'gender': gender,
        });
        await localStorage.insertData('players',
            Player(id: res.user!.id, userName: email.split('@')[0]).toJson());
      }
      isRegisterLoading.value = false;

      Get.snackbar(
        'Félicitations',
        'Ton compte a été créé',
        colorText: Colors.white,
        backgroundColor: AppColors.secondaryColor.withOpacity(0.6),
      );
      localStorage.setUserLoggedIn(true);

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
        // await localStorage.insertData(
        //     'players',
        //     Player(id: response.user!.id, userName: email.split('@')[0])
        //         .toJson());

        final existingUser = await localStorage.rawQuery(
            "SELECT * FROM players WHERE id = '${response.user!.id}'");
        if (existingUser != null) {
          await localStorage.updateData(
            "players",
            Player(id: response.user!.id, userName: email.split('@')[0])
                .toJson(),
          );
          localStorage.setUserLoggedIn(true);
        }
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
    final existingGuest = await localStorage
        .rawQuery("SELECT * FROM players WHERE name = 'Guest'");
    if (existingGuest.isEmpty) {
      try {
        await localStorage.insertData(
          "players",
          Player(id: "1", userName: 'Guest').toJson(),
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
    final res = await localStorage.getData('players');
    print(res);
    final currentPlayer = Player.fromJson(res.first);
    return currentPlayer;
  }
}
