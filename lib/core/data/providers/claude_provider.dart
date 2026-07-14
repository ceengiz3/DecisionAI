import 'dart:convert';
import 'package:dio/dio.dart';

import '../../domain/interfaces/ai_provider.dart';
import '../../domain/models/analysis_result.dart';

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
  }) async {
    final response = await _dio.post(
      '/messages',
      data: {
        'model': 'claude-3-5-sonnet-20241022',
        'max_tokens': 1500,
        'temperature': 0.7,
        'system':
            'You are a decision analysis assistant. Always respond with valid JSON only. No markdown, no code fences.',
        'messages': [
          {
            'role': 'user',
            'content':
                'Analyze this decision and return JSON with keys: recommendation (string), pros (array of strings), cons (array of strings), summary (string), confidenceScore (number 0-1).\n\nDecision: $title\nContext: $description',
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
