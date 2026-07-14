import 'dart:convert';
import 'package:dio/dio.dart';

import '../../domain/enums/decision_type.dart';
import '../../domain/interfaces/ai_provider.dart';
import '../../domain/models/analysis_result.dart';
import '../../services/prompt_builder.dart';

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
    DecisionType decisionType = DecisionType.custom,
  }) async {
    final response = await _dio.post(
      '/chat/completions',
      data: {
        'model': 'deepseek-chat',
        'messages': [
          {
            'role': 'system',
            'content': PromptBuilder.buildSystemPrompt(decisionType),
          },
          {
            'role': 'user',
            'content': PromptBuilder.buildUserPrompt(
              title: title,
              description: description,
            ),
          },
        ],
        'response_format': {'type': 'json_object'},
        'temperature': 0.7,
        'max_tokens': 2000,
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
      confidenceScore: (parsed['confidence'] as num).toDouble(),
      recommendation: parsed['recommendation'] as String,
      pros: List<String>.from(parsed['pros'] as List),
      cons: List<String>.from(parsed['cons'] as List),
      summary: parsed['summary'] as String,
      usedModel: displayName,
      analyzedAt: DateTime.now(),
      risks: List<String>.from(parsed['risks'] as List? ?? []),
      bestChoice: parsed['best_choice'] as String?,
      reasoning: parsed['reasoning'] as String?,
    );
  }
}
