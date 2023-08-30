import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/page/login_and_register.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const TestWidget(),
    );
  }
}
