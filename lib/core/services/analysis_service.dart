import '../data/providers/claude_provider.dart';
import '../data/providers/deepseek_provider.dart';
import '../data/providers/gemini_provider.dart';
import '../data/providers/openai_provider.dart';
import '../domain/enums/ai_provider_type.dart';
import '../domain/enums/decision_type.dart';
import '../domain/interfaces/ai_provider.dart';
import '../domain/models/analysis_result.dart';

class AnalysisService {
  AiProvider _createProvider(AiProviderType type, String apiKey) {
    switch (type) {
      case AiProviderType.openai:
        return OpenAiProvider(apiKey: apiKey);
      case AiProviderType.gemini:
        return GeminiProvider(apiKey: apiKey);
      case AiProviderType.claude:
        return ClaudeProvider(apiKey: apiKey);
      case AiProviderType.deepseek:
        return DeepSeekProvider(apiKey: apiKey);
    }
  }

  Future<AnalysisResult> analyze({
    required String title,
    required String description,
    required AiProviderType providerType,
    required String apiKey,
    DecisionType decisionType = DecisionType.custom,
  }) async {
    final provider = _createProvider(providerType, apiKey);
    return provider.analyze(
      title: title,
      description: description,
      decisionType: decisionType,
    );
  }
}
