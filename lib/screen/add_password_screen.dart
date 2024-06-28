
// lib/screens/add_password_screen.dart
import 'package:flutter/material.dart';
import 'package:password_manager/services/password_service.dart';
import '../models/password_entry.dart';
// import './services/password_service.dart';

class AddPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _accountTypeController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _categoryController = TextEditingController();
  final PasswordService _passwordService = PasswordService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _accountTypeController,
                decoration: InputDecoration(labelText: 'Account Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter account type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username/Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username/email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
                obscureText: true,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newEntry = PasswordEntry(
                      id: DateTime.now().toString(),
                      accountType: _accountTypeController.text,
                      username: _usernameController.text,
                      password: _passwordController.text,
                      category: _categoryController.text,
                    );
                    _passwordService.addPassword(newEntry);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
