import 'package:chat_app/page/login.dart';
import 'package:chat_app/page/register_page.dart';
import 'package:flutter/material.dart';

class LoginAndRegister extends StatefulWidget {
  const LoginAndRegister({super.key});

  @override
  State<LoginAndRegister> createState() => _LoginAndRegisterState();
}

class _LoginAndRegisterState extends State<LoginAndRegister> {
  bool showLoginPage = true;

  void changePage(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(changePage);
    }else{
      return RegisterPage(changePage);
    }
  }
}