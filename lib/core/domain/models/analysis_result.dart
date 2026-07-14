class AnalysisResult {
  final String decisionTitle;
  final String description;
  final double confidenceScore;
  final String recommendation;
  final List<String> pros;
  final List<String> cons;
  final String summary;
  final String usedModel;
  final DateTime analyzedAt;
  final List<String> risks;
  final String? bestChoice;
  final String? reasoning;

  const AnalysisResult({
    required this.decisionTitle,
    this.description = '',
    required this.confidenceScore,
    required this.recommendation,
    required this.pros,
    required this.cons,
    required this.summary,
    required this.usedModel,
    required this.analyzedAt,
    this.risks = const [],
    this.bestChoice,
    this.reasoning,
  });
}
