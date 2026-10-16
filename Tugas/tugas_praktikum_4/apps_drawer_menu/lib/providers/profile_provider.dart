import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String _nama = 'Nama Lengkap Kamu';
  String _nim = '20210000000';
  String _email = 'email@student.esaunggul.ac.id';
  String _prodi = 'Informatika';
  String _noHp = '08123456789';

  String get nama => _nama;
  String get nim => _nim;
  String get email => _email;
  String get prodi => _prodi;
  String get noHp => _noHp;

  void update({
    required String nama,
    required String nim,
    required String email,
    required String prodi,
    required String noHp,
  }) {
    _nama = nama;
    _nim = nim;
    _email = email;
    _prodi = prodi;
    _noHp = noHp;
    notifyListeners();
  }
}