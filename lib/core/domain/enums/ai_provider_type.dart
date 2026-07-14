enum AiProviderType {
  openai,
  gemini,
  claude,
  deepseek;

  String get displayName {
    switch (this) {
      case AiProviderType.openai:
        return 'GPT-4o';
      case AiProviderType.gemini:
        return 'Gemini Pro';
      case AiProviderType.claude:
        return 'Claude 3.5';
      case AiProviderType.deepseek:
        return 'DeepSeek';
    }
  }

  static AiProviderType fromDisplayName(String name) {
    switch (name) {
      case 'GPT-4o':
        return AiProviderType.openai;
      case 'Gemini Pro':
        return AiProviderType.gemini;
      case 'Claude 3.5':
        return AiProviderType.claude;
      case 'DeepSeek':
        return AiProviderType.deepseek;
      default:
        return AiProviderType.openai;
    }
  }
}
