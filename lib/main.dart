import 'package:flutter/material.dart';

import 'menu_screen.dart'; // Memanggil halaman menu yang sudah kita buat

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kantingo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      // Mengarahkan halaman utama aplikasi langsung ke MenuScreen
      home: const MenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
