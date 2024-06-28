// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../services/password_service.dart';
import '../models/password_entry.dart';
import '../widget/password_list.dart';
// import '../widgets/password_list.dart';

class HomeScreen extends StatelessWidget {
  final PasswordService _passwordService = PasswordService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Password Manager'),
        actions: [
          IconButton(onPressed:() {
              _passwordService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
             icon: const Icon(Icons.logout),)
    

        ],
      ),
      body: FutureBuilder<List<PasswordEntry>>(
        future: _passwordService.getPasswords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No passwords found'));
          } else {
            return PasswordList(passwords: snapshot.data!);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
