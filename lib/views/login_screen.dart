// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:note_firebase_app/components/show_snack_bar.dart';
import 'package:note_firebase_app/components/text_form_field.dart';
import 'package:note_firebase_app/views/chat_screen.dart';
import 'package:note_firebase_app/views/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final logController = TextEditingController();

  final passController = TextEditingController();

  bool isLoading = false;
  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 120,
          ),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LottieBuilder.asset(
                    'assets/lottie/data1.json',
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Login',
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
                          await loginUser();

                          Navigator.pushReplacementNamed(context, ChatScreen.id,
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
                            showSnackBar(
                              context,
                              message: 'email or password is wrong',
                            );
                          } else {
                            showSnackBar(context, message: e.code);
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
                        'Login',
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
                        "don't have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, RegisterScreen.id);
                        },
                        child: Text(
                          'Register',
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
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
