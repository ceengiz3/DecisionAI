import 'dart:convert';
import 'package:dio/dio.dart';

import '../../domain/enums/decision_type.dart';
import '../../domain/interfaces/ai_provider.dart';
import '../../domain/models/analysis_result.dart';
import '../../services/prompt_builder.dart';

class GeminiProvider extends AiProvider {
  final Dio _dio;

  GeminiProvider({required String apiKey})
    : _dio = Dio(
        BaseOptions(
          baseUrl:
              'https://generativelanguage.googleapis.com/v1beta/models',
          queryParameters: {'key': apiKey},
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
      );

  @override
  String get displayName => 'Gemini Pro';

  @override
  Future<AnalysisResult> analyze({
    required String title,
    required String description,
    DecisionType decisionType = DecisionType.custom,
  }) async {
    final response = await _dio.post(
      '/gemini-pro:generateContent',
      data: {
        'contents': [
          {
            'parts': [
              {
                'text':
                    '${PromptBuilder.buildSystemPrompt(decisionType)}\n\n${PromptBuilder.buildUserPrompt(title: title, description: description)}',
              },
            ],
          },
        ],
        'generationConfig': {
          'temperature': 0.7,
          'maxOutputTokens': 2000,
        },
      },
    );

    final data = response.data as Map<String, dynamic>;
    final candidates = data['candidates'] as List<dynamic>;
    final firstCandidate = candidates[0] as Map<String, dynamic>;
    final content = firstCandidate['content'] as Map<String, dynamic>;
    final parts = content['parts'] as List<dynamic>;
    final firstPart = parts[0] as Map<String, dynamic>;
    final text = firstPart['text'] as String;
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
