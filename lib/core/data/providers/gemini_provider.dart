import 'dart:convert';
import 'package:dio/dio.dart';

import '../../domain/interfaces/ai_provider.dart';
import '../../domain/models/analysis_result.dart';

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
  }) async {
    final response = await _dio.post(
      '/gemini-pro:generateContent',
      data: {
        'contents': [
          {
            'parts': [
              {
                'text':
                    'You are a decision analysis assistant. Analyze the following decision and return ONLY valid JSON with keys: recommendation (string), pros (array of strings), cons (array of strings), summary (string), confidenceScore (number 0-1). No markdown, no code fences.\n\nDecision: $title\nContext: $description',
              },
            ],
          },
        ],
        'generationConfig': {
          'temperature': 0.7,
          'maxOutputTokens': 1500,
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
