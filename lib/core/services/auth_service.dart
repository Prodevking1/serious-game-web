import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Get.find<SupabaseClient>();

  Future<AuthResponse> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _supabaseClient.auth.signUp(email: email, password: password);
  }

  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    return await _supabaseClient.auth
        .signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
}
