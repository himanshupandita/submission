// lib/services/password_service.dart
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/password_entry.dart';


class PasswordService {
  Future<List<PasswordEntry>> getPasswords() async {
    final prefs = await SharedPreferences.getInstance();
    final String? passwordsJson = prefs.getString('passwords');
    if (passwordsJson != null) {
      final List passwordsList = json.decode(passwordsJson);
      return passwordsList.map((e) => PasswordEntry.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> addPassword(PasswordEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final passwords = await getPasswords();
    passwords.add(entry);
    prefs.setString('passwords', json.encode(passwords));
  }

  Future<void> updatePassword(PasswordEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final passwords = await getPasswords();
    final index = passwords.indexWhere((e) => e.id == entry.id);
    if (index != -1) {
      passwords[index] = entry;
      prefs.setString('passwords', json.encode(passwords));
    }
  }

  Future<void> deletePassword(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final passwords = await getPasswords();
    passwords.removeWhere((e) => e.id == id);
    prefs.setString('passwords', json.encode(passwords));
  }
    Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user');
  }
}

