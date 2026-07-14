import '../enums/decision_type.dart';
import '../models/analysis_result.dart';

abstract class AiProvider {
  String get displayName;

  Future<AnalysisResult> analyze({
    required String title,
    required String description,
    DecisionType decisionType = DecisionType.custom,
  });
}
