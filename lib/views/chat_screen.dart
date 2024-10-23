// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase_app/components/chat_bubbles.dart';
import 'package:note_firebase_app/constants.dart';
import 'package:note_firebase_app/models/message.dart';
import 'package:note_firebase_app/views/login_screen.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static String id = 'Chat Screen';
  final ScrollController scrollController = ScrollController();

  CollectionReference message =
      FirebaseFirestore.instance.collection(kMessageCollection);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: message.orderBy(time, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              Message.fromJson(
                snapshot.data!.docs[i],
              ),
            );
          }
          return SafeArea(
            child: Scaffold(
              drawer: Drawer(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.id);
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ]),
              ),
              appBar: AppBar(
                bottomOpacity: 990,
                elevation: 50,
                backgroundColor: Colors.purple[288],
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ChatApp',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        // fontFamily: 'Pacifico''
                      ),
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBubbles(
                                message: messagesList[index],
                              )
                            : ChatBubblesForFriend(
                                message: messagesList[index],
                              );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        message.add(
                          {
                            kMessage: data,
                            time: DateTime.now(),
                            'id': email,
                          },
                        );
                        controller.clear();
                        scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      decoration: InputDecoration(
                          hintText: 'send message',
                          suffixIcon: IconButton(
                            onPressed: () {
                              message.add(
                                {
                                  kMessage: controller.text,
                                  time: DateTime.now(),
                                  'id': email,
                                },
                              );
                              controller.clear();
                            },
                            icon: const Icon(
                              Icons.send,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.deepPurple,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Colors.deepPurple, width: 2))),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Text(
              'Loading....',
            ),
          );
        }
      },
    );
  }
}
