import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase_app/firebase_options.dart';
import 'package:note_firebase_app/views/chat_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}