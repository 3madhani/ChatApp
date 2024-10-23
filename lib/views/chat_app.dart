import 'package:flutter/material.dart';
import 'package:note_firebase_app/views/chat_screen.dart';
import 'package:note_firebase_app/views/login_screen.dart';
import 'package:note_firebase_app/views/register_screen.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.id:(context) => const LoginScreen(),
        RegisterScreen.id:(context) => const RegisterScreen(),
        ChatScreen.id:(context) => ChatScreen(),
      },
      initialRoute: LoginScreen.id,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(

        useMaterial3: true,

      ),
    );
  }
}