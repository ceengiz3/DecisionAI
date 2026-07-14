import '../models/analysis_result.dart';

abstract class AiProvider {
  String get displayName;

  Future<AnalysisResult> analyze({
    required String title,
    required String description,
  });
}
