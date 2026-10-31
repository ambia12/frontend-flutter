import 'package:flutter/material.dart';
import 'services/api_service.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Future<Map<String, dynamic>?> futureMenus;

  @override
  void initState() {
    super.initState();
    futureMenus = ApiService.getMenus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Kantingo'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: futureMenus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!['data'] == null) {
            return const Center(
              child: Text('Gagal memuat data menu dari server.'),
            );
          }

          final data = snapshot.data!['data'];
          final menus = data['menus'] as List;

          return ListView.builder(
            itemCount: menus.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final menu = menus[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  title: Text(
                    menu['name'] ?? 'Tanpa Nama',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(menu['description'] ?? ''),
                  trailing: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Dipilih: ${menu['name']}')),
                      );
                    },
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
