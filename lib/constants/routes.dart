// lib/constants/routes.dart
import 'package:flutter/material.dart';
import 'package:password_manager/screen/home_screen.dart';
import 'package:password_manager/screen/register_screen.dart';
import '../screen/add_password_screen.dart';
import '../screen/login_screen.dart';
import '../screen/view_edit_password_screen.dart';


final Map<String, WidgetBuilder> routes = {
  '/': (context) => HomeScreen(),
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/add': (context) => AddPasswordScreen(),
  '/edit': (context) => ViewEditPasswordScreen(),
};
