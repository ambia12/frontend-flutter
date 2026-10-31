import 'package:flutter/material.dart';

import 'services/api_service.dart'; // Sesuaikan jalur import jika folder berbeda

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Future<Map<String, dynamic>?> futureMenus;

  @override
  void initState() {
    super.initState();
    // Memanggil API saat halaman pertama kali dibuka
    futureMenus = ApiService.getMenus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Kantingo 🍜'),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: futureMenus,
        builder: (context, snapshot) {
          // 1. Kondisi saat data masih loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. Kondisi jika terjadi error atau data kosong
          else if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!['data'] == null) {
            return const Center(
              child: Text('Gagal memuat data menu dari server.'),
            );
          }

          // 3. Mengambil data list menu dari struktur JSON Laravel
          final data = snapshot.data!['data'];
          final menus = data['menus'] as List;

          // 4. Menampilkan data ke ListView
          return ListView.builder(
            itemCount: menus.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final menu = menus[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  title: Text(
                    menu['name'] ?? 'Tanpa Nama',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(menu['description'] ?? 'Tidak ada deskripsi'),
                      const SizedBox(height: 8),
                      Text(
                        'Rp ${menu['price']}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Aksi ketika tombol tambah diklik (bisa dimasukkan ke keranjang)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Dipilih: ${menu['name']}')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Pilih'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
