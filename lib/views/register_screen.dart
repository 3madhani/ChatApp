// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:note_firebase_app/components/show_snack_bar.dart';
import 'package:note_firebase_app/components/text_form_field.dart';
import 'package:note_firebase_app/views/chat_screen.dart';
import 'package:note_firebase_app/views/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = 'Register Screen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final logController = TextEditingController();

  final passController = TextEditingController();
  String? email, password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 120,
              left: 10,
              right: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LottieBuilder.asset(
                  'assets/lottie/data.json',
                  height: 200,
                  width: 200,
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Register',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize:
                          Theme.of(context).textTheme.displayMedium!.fontSize,
                      color: Colors.deepPurpleAccent),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextInput(
                  onChange: (data) {
                    email = data;
                  },
                  icon: Icons.email_outlined,
                  controller: logController,
                  label: ' E-mail',
                  hint: ' example@gmail.com',
                ),
                const SizedBox(
                  height: 15,
                ),
                TextInput(
                  isHidden: true,
                  onChange: (data) {
                    password = data;
                  },
                  icon: Icons.key,
                  controller: passController,
                  label: ' Password',
                  hint: ' xxxxxxxx',
                ),
                const SizedBox(
                  height: 15,
                ),
                FilledButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        Navigator.pushReplacementNamed(
                          context,
                          ChatScreen.id,
                          arguments: email,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                            context,
                            message: 'The password provided is too weak.',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(
                            context,
                            message:
                                'The account already exists for that email.',
                          );
                        } else {
                          showSnackBar(context, message: e.code.toString());
                        }
                      } catch (e) {
                        showSnackBar(context, message: 'there was an error');
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "already have an account? ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, LoginScreen.id);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.deepPurple[700],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
