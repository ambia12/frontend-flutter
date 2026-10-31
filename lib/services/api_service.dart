import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Ganti URL ini sesuai perangkat yang kamu gunakan untuk testing:
  // - Android Emulator : 'http://10.0.2.2:8000/api'
  // - Flutter Web / PC : 'http://127.0.0.1:8000/api'
  // - HP Fisik (Android/iOS) : 'http://<IP_KOMPUTER_KAMU>:8000/api' (Contoh: 192.168.1.10:8000)
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // 1. Ambil Data Menu & Kategori dari Laravel
  static Future<Map<String, dynamic>?> getMenus() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/menus'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Gagal mengambil menu: $e');
    }
    return null;
  }

  // 2. Ambil Daftar Meja dari Laravel
  static Future<Map<String, dynamic>?> getTables() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tables'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Gagal mengambil meja: $e');
    }
    return null;
  }

  // 3. Kirim Pesanan Baru (Checkout) ke Laravel
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

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      print('Gagal mengirim pesanan: $e');
    }
    return false;
  }
}