import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ClaudeApiService {
  static const String baseUrl = "https://api.aimlapi.com/v1";
  static const String model = "mistralai/Mistral-7B-Instruct-v0.2";
  static const int maxTokens = 256;

  final String _apiKey;

  ClaudeApiService({required String apiKey}) : _apiKey = apiKey;

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chat/completions'),
        headers: getHeaders(),
        body: getRequeestBody(message),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data["choices"][0]["message"]["content"];
      } else {
        if (kDebugMode) {
          print(response.statusCode);
        }
        throw Exception("خطا در دریافت پاسخ: ${response.body}");
      }
    } catch (e) {
      throw Exception("خطا در اصال به سرور: $e");
    }
  }

  Map<String, String> getHeaders() => {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      };

  String getRequeestBody(String content) => jsonEncode({
        "model": model,
        "messages": [
          {
            "role": "user",
            "content": content,
          },
        ],
        "temperature": 0.7,
        "max_tokens": maxTokens,
      });
}
