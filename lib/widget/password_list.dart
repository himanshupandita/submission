// lib/widgets/password_list.dart
import 'package:flutter/material.dart';
import '../models/password_entry.dart';

class PasswordList extends StatelessWidget {
  final List<PasswordEntry> passwords;

  PasswordList({required this.passwords});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: passwords.length,
      itemBuilder: (context, index) {
        final passwordEntry = passwords[index];
        return Card(
          child: ListTile(
            title: Text(passwordEntry.accountType),
            subtitle: Text(passwordEntry.username),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/edit',
                  arguments: passwordEntry,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
