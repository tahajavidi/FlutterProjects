import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/chat/components/chat_bubble.dart';
import 'package:javidcoffee_android_app/features/chat/controllers/chat_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  static const routeName = "/chat";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (Responsive.isMobile(context)) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("AI Chat"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton.filledTonal(
                onPressed: () {
                  chatController.messages.clear();
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () {
                    if (chatController.messages.isEmpty) {
                      return const Center(
                        child: Text("گفت و گویی شروع کنید!"),
                      );
                    }

                    return ListView.builder(
                      itemCount: chatController.messages.length,
                      itemBuilder: (context, index) {
                        final message = chatController.messages[index];

                        if (kDebugMode) {
                          print(message.isUser);
                        }

                        return ChatBubble(message: message);
                      },
                    );
                  },
                ),
              ),
              Obx(
                () {
                  if (chatController.isLoading.value == true) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const SizedBox();
                },
              ),
              Localizations.override(
                context: context,
                locale: const Locale('en', 'US'),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    spacing: 10.0,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: chatController.messageController,
                          decoration: const InputDecoration(
                            labelText: "...پیام",
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          onPressed: () {
                            chatController.sendMessage(
                                chatController.messageController.text);
                            chatController.messageController.clear();
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(),
      );
    }
  }
}
