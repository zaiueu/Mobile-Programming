import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/nilai_provider.dart';
import 'providers/profile_provider.dart';
import 'pages/biodata_page.dart';
import 'pages/nilai_page.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NilaiProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Praktikum State Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<String> _titles = [
    'Biodata Mahasiswa',
    'Form Nilai Mahasiswa',
    'Profile Pengguna',
  ];

  final List<Widget> _pages = const [
    BiodataPage(),
    NilaiPage(),
    ProfilePage(),
  ];

  void _onSelectMenu(int index) {
    setState(() => _selectedIndex = index);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final profil = context.watch<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex]), centerTitle: true),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(profil.nama),
              accountEmail: Text(profil.email),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/pas foto.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Biodata Mahasiswa'),
              selected: _selectedIndex == 0,
              onTap: () => _onSelectMenu(0),
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Form Nilai Mahasiswa'),
              selected: _selectedIndex == 1,
              onTap: () => _onSelectMenu(1),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile Pengguna'),
              selected: _selectedIndex == 2,
              onTap: () => _onSelectMenu(2),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}