import 'dart:convert';
import 'package:dio/dio.dart';

import '../../domain/interfaces/ai_provider.dart';
import '../../domain/models/analysis_result.dart';

class DeepSeekProvider extends AiProvider {
  final Dio _dio;

  DeepSeekProvider({required String apiKey})
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://api.deepseek.com/v1',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
      );

  @override
  String get displayName => 'DeepSeek';

  @override
  Future<AnalysisResult> analyze({
    required String title,
    required String description,
  }) async {
    final response = await _dio.post(
      '/chat/completions',
      data: {
        'model': 'deepseek-chat',
        'messages': [
          {
            'role': 'system',
            'content':
                'You are a decision analysis assistant. Analyze the decision and return valid JSON with keys: recommendation (string), pros (array of strings), cons (array of strings), summary (string), confidenceScore (number 0-1).',
          },
          {
            'role': 'user',
            'content': 'Decision: $title\nContext: $description',
          },
        ],
        'response_format': {'type': 'json_object'},
        'temperature': 0.7,
        'max_tokens': 1500,
      },
    );

    final data = response.data as Map<String, dynamic>;
    final choices = data['choices'] as List<dynamic>;
    final firstChoice = choices[0] as Map<String, dynamic>;
    final message = firstChoice['message'] as Map<String, dynamic>;
    final content = message['content'] as String;
    final parsed = jsonDecode(content) as Map<String, dynamic>;

    return AnalysisResult(
      decisionTitle: title,
      confidenceScore: (parsed['confidenceScore'] as num).toDouble(),
      recommendation: parsed['recommendation'] as String,
      pros: List<String>.from(parsed['pros'] as List),
      cons: List<String>.from(parsed['cons'] as List),
      summary: parsed['summary'] as String,
      usedModel: displayName,
      analyzedAt: DateTime.now(),
    );
  }
}
