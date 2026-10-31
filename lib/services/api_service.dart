import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service komunikasi API HTTP dengan backend Laravel Kantingo.
class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  /// Mengambil daftar menu dan kategori dari server.
  static Future<Map<String, dynamic>?> getMenus() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/menus'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  /// Mengambil daftar status meja kantin.
  static Future<Map<String, dynamic>?> getTables() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tables'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  /// Mengirim data transaksi pesanan baru ke server.
  static Future<bool> storeOrder({
    required int tableId,
    required String customerName,
    required List<Map<String, dynamic>> items,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/orders'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'table_id': tableId,
          'customer_name': customerName,
          'items': items,
        }),
      );

      return response.statusCode == 201;
    } catch (_) {
      return false;
    }
  }
}
