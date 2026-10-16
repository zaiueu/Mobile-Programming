import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/nilai_provider.dart';

class NilaiPage extends StatefulWidget {
  const NilaiPage({super.key});

  @override
  State<NilaiPage> createState() => _NilaiPageState();
}

class _NilaiPageState extends State<NilaiPage> {
  final _formKey = GlobalKey<FormState>();
  final _nama = TextEditingController();
  final _nim = TextEditingController();
  final _matkul = TextEditingController();
  final _tugas = TextEditingController();
  final _uts = TextEditingController();
  final _uas = TextEditingController();

  @override
  void dispose() {
    _nama.dispose();
    _nim.dispose();
    _matkul.dispose();
    _tugas.dispose();
    _uts.dispose();
    _uas.dispose();
    super.dispose();
  }

  String? _wajib(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null;

  String? _angka(String? v) {
    final n = double.tryParse(v ?? '');
    if (n == null) return 'Isi angka';
    if (n < 0 || n > 100) return '0 - 100';
    return null;
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    context.read<NilaiProvider>().tambah(
          Nilai(
            nama: _nama.text.trim(),
            nim: _nim.text.trim(),
            matkul: _matkul.text.trim(),
            tugas: double.parse(_tugas.text),
            uts: double.parse(_uts.text),
            uas: double.parse(_uas.text),
          ),
        );

    _formKey.currentState!.reset();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data nilai berhasil disimpan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final daftar = context.watch<NilaiProvider>().daftar;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ---------- FORM ----------
        Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text('Input Nilai Mahasiswa',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nama,
                    decoration: const InputDecoration(
                        labelText: 'Nama Mahasiswa',
                        border: OutlineInputBorder()),
                    validator: _wajib,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nim,
                    decoration: const InputDecoration(
                        labelText: 'NIM', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: _wajib,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _matkul,
                    decoration: const InputDecoration(
                        labelText: 'Mata Kuliah', border: OutlineInputBorder()),
                    validator: _wajib,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _tugas,
                          decoration: const InputDecoration(
                              labelText: 'Tugas',
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                          validator: _angka,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _uts,
                          decoration: const InputDecoration(
                              labelText: 'UTS', border: OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                          validator: _angka,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _uas,
                          decoration: const InputDecoration(
                              labelText: 'UAS', border: OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                          validator: _angka,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _simpan,
                      icon: const Icon(Icons.save),
                      label: const Text('Simpan'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),
        Text('Daftar Nilai (${daftar.length})',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // ---------- LISTVIEW ----------
        if (daftar.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: Text('Belum ada data nilai')),
          )
        else
          ...List.generate(daftar.length, (i) {
            final n = daftar[i];
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text(n.grade)),
                title: Text('${n.nama} (${n.nim})'),
                subtitle: Text(
                    '${n.matkul}\nTugas ${n.tugas.toStringAsFixed(0)} | UTS ${n.uts.toStringAsFixed(0)} | UAS ${n.uas.toStringAsFixed(0)}'),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(n.nilaiAkhir.toStringAsFixed(1),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () =>
                          context.read<NilaiProvider>().hapus(i),
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }
}