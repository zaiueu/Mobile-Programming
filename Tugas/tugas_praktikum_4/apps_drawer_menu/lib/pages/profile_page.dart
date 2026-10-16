import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _editProfil(BuildContext context) {
    final p = context.read<ProfileProvider>();
    final nama = TextEditingController(text: p.nama);
    final nim = TextEditingController(text: p.nim);
    final email = TextEditingController(text: p.email);
    final prodi = TextEditingController(text: p.prodi);
    final noHp = TextEditingController(text: p.noHp);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Profil'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nama,
                  decoration: const InputDecoration(labelText: 'Nama')),
              TextField(
                  controller: nim,
                  decoration: const InputDecoration(labelText: 'NIM')),
              TextField(
                  controller: email,
                  decoration: const InputDecoration(labelText: 'Email')),
              TextField(
                  controller: prodi,
                  decoration:
                      const InputDecoration(labelText: 'Program Studi')),
              TextField(
                  controller: noHp,
                  decoration: const InputDecoration(labelText: 'No. HP')),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal')),
          FilledButton(
            onPressed: () {
              p.update(
                nama: nama.text,
                nim: nim.text,
                email: email.text,
                prodi: prodi.text,
                noHp: noHp.text,
              );
              Navigator.pop(ctx);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ProfileProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.indigo.shade100,
            backgroundImage: const AssetImage('assets/images/pas foto.jpg'),
            onBackgroundImageError: (_, __) {},
          ),
          const SizedBox(height: 12),
          Text(p.nama,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text(p.prodi, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                ListTile(
                    leading: const Icon(Icons.badge),
                    title: const Text('NIM'),
                    subtitle: Text(p.nim)),
                const Divider(height: 0),
                ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(p.email)),
                const Divider(height: 0),
                ListTile(
                    leading: const Icon(Icons.school),
                    title: const Text('Program Studi'),
                    subtitle: Text(p.prodi)),
                const Divider(height: 0),
                ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('No. HP'),
                    subtitle: Text(p.noHp)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => _editProfil(context),
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profil'),
            ),
          ),
        ],
      ),
    );
  }
}