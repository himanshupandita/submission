// lib/services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class AuthService {
  Future<void> register(String username, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList('users') ?? [];
    final hashedPassword = _hashPassword(password);

    // Check if email is already registered
    for (var user in users) {
      final userData = json.decode(user);
      if (userData['email'] == email) {
        throw Exception('Email is already registered');
      }
    }

    final newUser = {
      'username': username,
      'email': email,
      'password': hashedPassword,
    };
    users.add(json.encode(newUser));
    await prefs.setStringList('users', users);
  }

  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList('users') ?? [];
    final hashedPassword = _hashPassword(password);

    for (var user in users) {
      final userData = json.decode(user);
      if (userData['email'] == email && userData['password'] == hashedPassword) {
        // Save the current user session
        await prefs.setString('current_user', user);
        return;
      }
    }

    throw Exception('Invalid email or password');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user');
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUser = prefs.getString('current_user');
    if (currentUser != null) {
      return json.decode(currentUser);
    }
    return null;
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
