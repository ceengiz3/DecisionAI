class AnalysisResult {
  final String decisionTitle;
  final double confidenceScore;
  final String recommendation;
  final List<String> pros;
  final List<String> cons;
  final String summary;
  final String usedModel;
  final DateTime analyzedAt;

  const AnalysisResult({
    required this.decisionTitle,
    required this.confidenceScore,
    required this.recommendation,
    required this.pros,
    required this.cons,
    required this.summary,
    required this.usedModel,
    required this.analyzedAt,
  });
}
