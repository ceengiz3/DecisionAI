import 'dart:convert';
import 'package:dio/dio.dart';

import '../../domain/enums/decision_type.dart';
import '../../domain/interfaces/ai_provider.dart';
import '../../domain/models/analysis_result.dart';
import '../../services/prompt_builder.dart';

class ClaudeProvider extends AiProvider {
  final Dio _dio;

  ClaudeProvider({required String apiKey})
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://api.anthropic.com/v1',
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': apiKey,
            'anthropic-version': '2023-06-01',
          },
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
      );

  @override
  String get displayName => 'Claude 3.5';

  @override
  Future<AnalysisResult> analyze({
    required String title,
    required String description,
    DecisionType decisionType = DecisionType.custom,
  }) async {
    final response = await _dio.post(
      '/messages',
      data: {
        'model': 'claude-3-5-sonnet-20241022',
        'max_tokens': 2000,
        'temperature': 0.7,
        'system': PromptBuilder.buildSystemPrompt(decisionType),
        'messages': [
          {
            'role': 'user',
            'content': PromptBuilder.buildUserPrompt(
              title: title,
              description: description,
            ),
          },
        ],
      },
    );

    final data = response.data as Map<String, dynamic>;
    final contentList = data['content'] as List<dynamic>;
    final firstContent = contentList[0] as Map<String, dynamic>;
    final text = firstContent['text'] as String;
    final cleaned = text.replaceAll(RegExp(r'```(?:json)?\s*|\s*```'), '');
    final parsed = jsonDecode(cleaned) as Map<String, dynamic>;

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
