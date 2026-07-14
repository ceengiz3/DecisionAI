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

AnalysisResult generateMockResult({String? title, String? description, String? model}) {
  return AnalysisResult(
    decisionTitle: title ?? 'Investment Portfolio',
    confidenceScore: 0.87,
    recommendation:
        'Prioritize a diversified tech-focused portfolio with a 70/30 split between growth stocks and bonds to balance returns with manageable risk.',
    pros: [
      'Higher long-term growth potential in the technology sector compared to traditional investments',
      'Strong historical performance of AI, cloud computing, and semiconductor companies',
      'Diversification opportunities across multiple tech subsectors reduce single-point risk',
    ],
    cons: [
      'Increased短期 volatility compared to bonds and fixed-income securities',
      'Higher susceptibility to market downturns and economic cycles',
      'Requires more active portfolio management and ongoing market monitoring',
    ],
    summary:
        'Based on your preferences for growth and moderate risk tolerance, a tech-focused portfolio allocation offers the best balance of potential returns and manageable risk. The analysis suggests a 70% allocation to diversified tech stocks and 30% to government bonds.',
    usedModel: model ?? 'GPT-4o',
    analyzedAt: DateTime.now(),
  );
}
