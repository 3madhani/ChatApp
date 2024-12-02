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

  List<Message> messageList = [
    Message(
      'i am jon',
      '1',
    ),
    Message(
      'i am Emad',
      '1',
    ),
    Message(
      'Hi',
      '1',
    ),
    Message(
      'Hi',
      '1',
    ),
  ];

  List<Message> messageList2 = [];
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Spacer(
              flex: 1,
            ),
            FilledButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginScreen.id);
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
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  return index % 2 != 0
                      ? ChatBubbles(
                          message: messageList[index],
                        )
                      : ChatBubblesForFriend(
                          message: messageList[index],
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
  }
}
