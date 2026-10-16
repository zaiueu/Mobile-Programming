import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Drawer Menu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ======================= HALAMAN UTAMA + DRAWER =======================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<String> _titles = ['Biodata', 'Hobi & Keahlian'];

  final List<Widget> _pages = const [
    BiodataPage(),
    HobiPage(),
  ];

  void _onSelectMenu(int index) {
    setState(() => _selectedIndex = index);
    Navigator.pop(context); // tutup drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Zaidan Jainul Insan'),
              accountEmail: const Text('zaidan120500@student.esaunggul.ac.id'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage('assets/images/pas foto.jpg'),
                onBackgroundImageError: (_, __) {},
                child: null,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Biodata'),
              selected: _selectedIndex == 0,
              onTap: () => _onSelectMenu(0),
            ),
            ListTile(
              leading: const Icon(Icons.interests),
              title: const Text('Hobi & Keahlian'),
              selected: _selectedIndex == 1,
              onTap: () => _onSelectMenu(1),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Tentang Aplikasi'),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: 'Aplikasi Drawer Menu',
                  applicationVersion: '1.0.0',
                );
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

// ======================= MENU 1: BIODATA =======================
class BiodataPage extends StatelessWidget {
  const BiodataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // ---------- FOTO ----------
          const SizedBox(height: 8),
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.indigo.shade100,
            backgroundImage: const AssetImage('assets/images/pas foto.jpg'),
            onBackgroundImageError: (_, __) {},
          ),
          const SizedBox(height: 12),
          const Text(
            'Zaidan Jainul Insan',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Mahasiswa Informatika',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // ---------- DATA PRIBADI ----------
          const SectionCard(
            title: 'Data Pribadi',
            icon: Icons.badge,
            items: [
              InfoRow(label: 'Nama', value: 'Zaidan Jainul Insan'),
              InfoRow(label: 'Tempat, Tgl Lahir', value: 'Bandung, 12 Mei 2000'),
              InfoRow(label: 'Jenis Kelamin', value: 'Laki-laki'),
              InfoRow(label: 'Alamat', value: 'Griya Asri Taman Mini Blok H3 no.2'),
              InfoRow(label: 'No. HP', value: '081245929975'),
              InfoRow(label: 'Email', value: 'zaidan120500@student.esaunggul.ac.id'),
            ],
          ),

          // ---------- DATA PENDIDIKAN ----------
          const SectionCard(
            title: 'Data Pendidikan',
            icon: Icons.school,
            items: [
              InfoRow(label: 'SD', value: 'SDIT Al-Khairaat (2006 - 2012)'),
              InfoRow(label: 'SMP', value: 'MTSN 7 Ciracas (2012 - 2015)'),
              InfoRow(label: 'SMA/SMK', value: 'SMA Negeri 62 Jakarta (2015 - 2018)'),
              InfoRow(
                  label: 'Perguruan Tinggi',
                  value: 'Universitas Esa Unggul - Informatika (2022 - sekarang)'),
            ],
          ),

          // ---------- DATA PEKERJAAN ----------
          const SectionCard(
            title: 'Data Pekerjaan',
            icon: Icons.work,
            items: [
              InfoRow(label: 'Posisi', value: '-'),
              InfoRow(label: 'Perusahaan', value: '-'),
              InfoRow(label: 'Periode', value: '-'),
              InfoRow(
                  label: 'Deskripsi',
                  value: '-'),
            ],
          ),
          const SectionCard(
            title: 'Data Organisasi',
            icon: Icons.groups,
            items: [
              InfoRow(label: 'Organisasi', value: '-'),
              InfoRow(label: 'Jabatan', value: '-'),
              InfoRow(label: 'Periode', value: '-'),
            ],
          ),
        ],
      ),
    );
  }
}

// ======================= MENU 2 (BEBAS): HOBI & KEAHLIAN =======================
class HobiPage extends StatelessWidget {
  const HobiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hobi = [
      {'nama': 'Coding', 'icon': Icons.code},
      {'nama': 'Membaca', 'icon': Icons.menu_book},
      {'nama': 'Gaming', 'icon': Icons.sports_esports},
      {'nama': 'Musik', 'icon': Icons.music_note},
    ];

    final skill = ['Flutter', 'Dart', 'Python', 'Arduino / IoT', 'MySQL'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Hobi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: hobi
                .map((h) => Card(
                      elevation: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(h['icon'] as IconData,
                              size: 36, color: Colors.indigo),
                          const SizedBox(height: 6),
                          Text(h['nama'] as String),
                        ],
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          const Text('Keahlian',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skill
                .map((s) => Chip(
                      avatar: const Icon(Icons.check_circle, size: 18),
                      label: Text(s),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ======================= WIDGET BANTU (REUSABLE) =======================
class SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> items;

  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.indigo),
                const SizedBox(width: 8),
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 20),
            ...items,
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          const Text(': '),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}