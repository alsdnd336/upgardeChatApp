import 'package:chat_app/page/Home_page.dart';
import 'package:chat_app/page/login_and_register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return const HomePage();
          }
          // user is NOT logged in 
          else {
            return const LoginAndRegister();
          }
        },
      ),
    );
  }
}