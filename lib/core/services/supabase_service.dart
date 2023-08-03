

import 'package:supabase/supabase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseClientService {
  late final SupabaseClient? _supabaseClient;

  SupabaseClientService()
      : _supabaseClient = SupabaseClient(
            dotenv.env['SUPABASE_URL']!, dotenv.env['SUPABASE_KEY']!);
}
