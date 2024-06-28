// lib/screens/view_edit_password_screen.dart
import 'package:flutter/material.dart';
import '../models/password_entry.dart';
import '../services/password_service.dart';

class ViewEditPasswordScreen extends StatefulWidget {
  @override
  _ViewEditPasswordScreenState createState() => _ViewEditPasswordScreenState();
}

class _ViewEditPasswordScreenState extends State<ViewEditPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late PasswordEntry _passwordEntry;
  final _accountTypeController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _categoryController = TextEditingController();
  final PasswordService _passwordService = PasswordService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _passwordEntry = ModalRoute.of(context)!.settings.arguments as PasswordEntry;
    _accountTypeController.text = _passwordEntry.accountType;
    _usernameController.text = _passwordEntry.username;
    _passwordController.text = _passwordEntry.password;
    _categoryController.text = _passwordEntry.category;
  }

  void _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      final updatedEntry = PasswordEntry(
        id: _passwordEntry.id,
        accountType: _accountTypeController.text,
        username: _usernameController.text,
        password: _passwordController.text,
        category: _categoryController.text,
      );
      await _passwordService.updatePassword(updatedEntry);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Password'),
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
                onPressed: _updatePassword,
                child: Text('Update Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
