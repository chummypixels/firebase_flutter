import 'package:firebase_crypto/net/flutterfire.dart';
import 'package:flutter/material.dart';

import 'home_view.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.0,
            ),
            TextFormField(
              controller: _emailField,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'something@email.com',
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: _passwordField,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNavigate =
                      await register(_emailField.text, _passwordField.text);
                  if (shouldNavigate) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeView(),
                      ),
                    );
                  }
                },
                child: Text('Register'),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNavigate =
                      await signIn(_emailField.text, _passwordField.text);
                  if (shouldNavigate) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeView(),
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
