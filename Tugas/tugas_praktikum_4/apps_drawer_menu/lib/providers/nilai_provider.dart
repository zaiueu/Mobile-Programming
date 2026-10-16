import 'package:flutter/material.dart';

class Nilai {
  final String nama;
  final String nim;
  final String matkul;
  final double tugas;
  final double uts;
  final double uas;

  Nilai({
    required this.nama,
    required this.nim,
    required this.matkul,
    required this.tugas,
    required this.uts,
    required this.uas,
  });

  // Bobot: Tugas 30%, UTS 30%, UAS 40% (sesuaikan dengan ketentuan dosen)
  double get nilaiAkhir => (tugas * 0.3) + (uts * 0.3) + (uas * 0.4);

  String get grade {
    final n = nilaiAkhir;
    if (n >= 85) return 'A';
    if (n >= 75) return 'B';
    if (n >= 65) return 'C';
    if (n >= 50) return 'D';
    return 'E';
  }
}

class NilaiProvider extends ChangeNotifier {
  final List<Nilai> _daftar = [];

  List<Nilai> get daftar => List.unmodifiable(_daftar);

  void tambah(Nilai nilai) {
    _daftar.add(nilai);
    notifyListeners(); // beri tahu UI untuk rebuild
  }

  void hapus(int index) {
    _daftar.removeAt(index);
    notifyListeners();
  }
}