/// Supabase project URL and anon key from compile-time defines (never commit real keys in source).
///
/// Run:
/// `flutter run --dart-define=SUPABASE_URL=https://xxxx.supabase.co --dart-define=SUPABASE_ANON_KEY=eyJ...`
class SupabaseConfig {
  SupabaseConfig._();

  static const String url = String.fromEnvironment('SUPABASE_URL', defaultValue: '');
  static const String anonKey = String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');

  static bool get isConfigured => url.isNotEmpty && anonKey.isNotEmpty;
}
