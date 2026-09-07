import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientService {
  SupabaseClient? _client;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized && _client != null;
  SupabaseClient? get client => _client;

  Future<void> init() async {
    try {
      final url = dotenv.maybeGet('SUPABASE_URL') ?? '';
      final anonKey = dotenv.maybeGet('SUPABASE_ANON_KEY') ?? '';

      if (url.isNotEmpty &&
          anonKey.isNotEmpty &&
          !url.contains('placeholder') &&
          Uri.tryParse(url)?.hasAbsolutePath == true) {
        await Supabase.initialize(
          url: url,
          anonKey: anonKey,
        );
        _client = Supabase.instance.client;
        _isInitialized = true;
        debugPrint("[Supabase] Inisialisasi berhasil.");
      } else {
        debugPrint("[Supabase] Kredensial belum diisi atau masih placeholder. Menggunakan fallback data.");
      }
    } catch (e) {
      debugPrint("[Supabase] Gagal inisialisasi: $e");
      _isInitialized = false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchTable(String table) async {
    if (!isInitialized || _client == null) {
      return [];
    }
    final response = await _client!.from(table).select();
    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>?> fetchSingle(String table, String column, dynamic value) async {
    if (!isInitialized || _client == null) {
      return null;
    }
    final response = await _client!.from(table).select().eq(column, value).maybeSingle();
    return response != null ? Map<String, dynamic>.from(response) : null;
  }
}
