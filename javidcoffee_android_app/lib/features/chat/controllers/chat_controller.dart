import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/features/chat/models/message.dart';
import 'package:javidcoffee_android_app/features/chat/services/claude_api_service.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final apiService =
      ClaudeApiService(apiKey: "854a8cba53634149876e3339ced36e26");

  final RxList<Message> messages = <Message>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    isLoading.value = true;

    try {
      final userMessage = Message(
        content: content,
        isUser: true,
        timestamp: DateTime.now(),
      );

      messages.add(userMessage);

      final response = await apiService.sendMessage(content);
      final responseMessage = Message(
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      );
      messages.add(responseMessage);

      isLoading.value = false;
    } catch (e) {
      final errorMessage = Message(
        content: "خطا در دریافت پاسخ: $e",
        isUser: false,
        timestamp: DateTime.now(),
      );

      StatusDialog().showError(errorMessage.content);

      messages.add(errorMessage);

      if (kDebugMode) {
        print(e);
      }

      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
