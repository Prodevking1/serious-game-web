import 'package:flame_game/core/services/auth_service.dart';
import 'package:get/get.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  @override
  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final response =
          await _authService.signInWithEmailAndPassword(email, password);

      final user = response.user;
      if (user != null) {
        return user;
      } else {
        return;
      }
    } catch (e) {
      Get.snackbar('Erreur', e.toString());
      throw Exception(e.toString());
    } finally {}
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String type}) async {
    try {
      final response =
          await _authService.signUpWithEmailAndPassword(email, password);
      final user = response.user;

      if (user == null) {
        return;
      }
      return user;
    } catch (e) {
      Get.snackbar('Erreur', e.toString());
    } finally {}
  }
}
