import 'package:whatsup_v1/components.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsup_v1/screens/chat_screen.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  String email = '';
  String pass = '';
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 150.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration:
                  kInputDecoration.copyWith(hintText: 'Enter Your Email'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                pass = value;
              },
              decoration:
                  kInputDecoration.copyWith(hintText: 'Enter Your Password'),
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              onPressed: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: pass);
                  if (user != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  } else {
                    print('No User Found');
                  }
                } catch (e) {
                  print(e);
                }
              },
              title: 'Log In',
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
