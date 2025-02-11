import 'package:flutter/material.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  static const routeName = "/chat";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (Responsive.isMobile(context)) {
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("AI Chat"),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(),
      );
    }
  }
}
