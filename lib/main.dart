import 'package:flutter/material.dart';
import 'package:whatsup_v1/screens/welcome_screen.dart';
import 'package:whatsup_v1/screens/login_screen.dart';
import 'package:whatsup_v1/screens/registration_screen.dart';
import 'package:whatsup_v1/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Whatsup());
}

class Whatsup extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ()async {
      final firebase = await Firebase.initializeApp();
    };
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id : (context) => ChatScreen()
      },
    );
  }
}
