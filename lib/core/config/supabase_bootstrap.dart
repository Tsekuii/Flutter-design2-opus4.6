import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_config.dart';

Future<void> initializeSupabase() async {
  if (!SupabaseConfig.isConfigured) return;
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );
}
