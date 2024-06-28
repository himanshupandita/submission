// lib/models/password_entry.dart
// import 'dart:convert';

class PasswordEntry {
  String id;
  String accountType;
  String username;
  String password;
  String category;

  PasswordEntry({
    required this.id,
    required this.accountType,
    required this.username,
    required this.password,
    required this.category,
  });

  factory PasswordEntry.fromJson(Map<String, dynamic> json) {
    return PasswordEntry(
      id: json['id'],
      accountType: json['accountType'],
      username: json['username'],
      password: json['password'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountType': accountType,
      'username': username,
      'password': password,
      'category': category,
    };
  }
}
