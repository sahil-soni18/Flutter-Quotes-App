import 'package:flutter/material.dart';
import 'quotes.dart';
import 'login.dart';
import 'quotes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  String _userName = '';

  void _loginUser(String userName) {
    setState(() {
      _isLoggedIn = true;
      _userName = userName;
    });
  }

  void _logoutUser() {
    setState(() {
      _isLoggedIn = false;
      _userName = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _isLoggedIn
          ? QuotePage(userName: _userName, logoutUser: _logoutUser)
          : LoginPage(loginUser: _loginUser),
    );
  }
}
