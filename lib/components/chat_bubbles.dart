import 'package:flutter/material.dart';
import 'package:note_firebase_app/models/message.dart';

class ChatBubbles extends StatelessWidget {
  const ChatBubbles({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding:
            const EdgeInsets.only(left: 16, top: 24, bottom: 24, right: 24),
        decoration: const BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(26),
              topLeft: Radius.circular(26),
              bottomRight: Radius.circular(26),
            )),
        child: Text(
          message.message,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}


class ChatBubblesForFriend extends StatelessWidget {
  const ChatBubblesForFriend({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding:
            const EdgeInsets.only(left: 16, top: 24, bottom: 24, right: 24),
        decoration: BoxDecoration(
            color: Colors.grey[700],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(26),
              bottomLeft: Radius.circular(26),
              topLeft: Radius.circular(26),
            )),
        child: Text(
          message.message,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
