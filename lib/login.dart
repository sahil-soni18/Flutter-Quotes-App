import 'package:flutter/material.dart';
import 'quotes.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Function loginUser;

  LoginPage({required this.loginUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Perform login logic here
                String email = _emailController.text;
                String password = _passwordController.text;
                print('Email: $email, Password: $password');

                // Check if email and password are correct
                if (email == 'Email@gmail.com' && password == 'Password') {
                  // Extract the user's name from the email
                  String userName = email.split('@')[0];

                  // Call the loginUser function from the parent widget
                  loginUser(userName);
                } else {
                  // Show an error message or handle incorrect credentials
                  print('Invalid email or password');
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                // Navigate to signup page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage(loginUser: loginUser)),
                );
              },
              child: Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Function loginUser;

  SignupPage({required this.loginUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Perform signup logic here
                String email = _emailController.text;
                String password = _passwordController.text;
                print('Email: $email, Password: $password');

                // Check if email and password are correct
                if (email == 'Email@gmail.com' && password == 'Password') {
                  // Extract the user's name from the email
                  String userName = email.split('@')[0];

                  // Call the loginUser function from the parent widget
                  loginUser(userName);
                } else {
                  // Show an error message or handle incorrect credentials
                  print('Invalid email or password');
                }
              },
              child: Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}