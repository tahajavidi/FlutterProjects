import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:javidcoffee_android_app/features/chat/models/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(18.0),
        margin: EdgeInsets.only(
          top: 6.0,
          bottom: 6.0,
          left: message.isUser ? 50.0 : 8.0,
          right: message.isUser ? 8.0 : 50.0,
        ),
        decoration: BoxDecoration(
          color: message.isUser
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(50.0),
            topRight: const Radius.circular(50.0),
            bottomLeft: message.isUser
                ? const Radius.circular(50.0)
                : const Radius.circular(0.0),
            bottomRight: message.isUser
                ? const Radius.circular(0.0)
                : const Radius.circular(50.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: message.isUser
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          spacing: 12.0,
          children: [
            Text(message.content),
            Text(
              DateFormat.jm().format(message.timestamp),
              style: const TextStyle(fontFamily: "vazir", fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
