import 'package:chatapp/Pages/homePage.dart';
import 'package:chatapp/Services/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authget extends StatelessWidget {
  const Authget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged
          if (snapshot.hasData) {
            return const HomePage();
          }
          //user is not logged
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
