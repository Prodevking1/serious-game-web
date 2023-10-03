import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

class AuthService {
  final SupabaseClient supabaseClient =
      SupabaseClient(dotenv.env['SUPABASE_URL']!, dotenv.env['SUPABASE_KEY']!);

  Future<AuthResponse> signUpWithEmailAndPassword(
      String email, String password) async {
    return await supabaseClient.auth.signUp(email: email, password: password);
  }

  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    return await supabaseClient.auth
        .signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }
}
