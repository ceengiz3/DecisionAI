import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../../core/database/isar_database.dart';
import '../../../../core/database/models/decision_record.dart';
import '../mock_data.dart';
import '../widgets/confidence_score_card.dart';
import '../widgets/pros_cons_section.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/result_action_bar.dart';

class AnalysisResultScreen extends StatefulWidget {
  final String? title;
  final String? description;
  final String? model;
  final DecisionRecord? existingRecord;

  const AnalysisResultScreen({
    super.key,
    this.title,
    this.description,
    this.model,
    this.existingRecord,
  });

  @override
  State<AnalysisResultScreen> createState() => _AnalysisResultScreenState();
}

class _AnalysisResultScreenState extends State<AnalysisResultScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _confidenceAnimation;
  late final Animation<double> _recommendationAnimation;
  late final Animation<double> _prosConsAnimation;
  late final Animation<double> _actionAnimation;

  late final AnalysisResult _result;
  late final bool _isExisting;
  late final DateTime _analyzedAt;

  @override
  void initState() {
    super.initState();

    if (widget.existingRecord != null) {
      final r = widget.existingRecord!;
      _result = AnalysisResult(
        decisionTitle: r.title ?? 'Untitled Decision',
        confidenceScore: r.confidenceScore,
        recommendation: r.recommendation,
        pros: r.pros,
        cons: r.cons,
        summary: r.summary,
        usedModel: r.model,
        analyzedAt: r.createdAt,
      );
      _isExisting = true;
      _analyzedAt = r.createdAt;
    } else {
      _result = generateMockResult(
        title: widget.title,
        description: widget.description,
        model: widget.model,
      );
      _isExisting = false;
      _analyzedAt = DateTime.now();
      _saveToIsar();
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _confidenceAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
    );
    _recommendationAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 0.5, curve: Curves.easeOutCubic),
    );
    _prosConsAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.65, curve: Curves.easeOutCubic),
    );
    _actionAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.8, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  Future<void> _saveToIsar() async {
    final record = DecisionRecord()
      ..title = widget.title?.isNotEmpty == true ? widget.title : null
      ..description = widget.description ?? ''
      ..model = widget.model ?? 'GPT-4o'
      ..confidenceScore = _result.confidenceScore
      ..recommendation = _result.recommendation
      ..prosJson = jsonEncode(_result.pros)
      ..consJson = jsonEncode(_result.cons)
      ..summary = _result.summary
      ..createdAt = _analyzedAt;
    await IsarDatabase.saveDecision(record);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDateTime(DateTime dt) {
    final month = dt.month.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    final year = dt.year.toString();
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$month/$day/$year, $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Decision Analysis'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth =
              constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: SizedBox(
                width: maxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(theme, colorScheme),
                    const SizedBox(height: 20),
                    _AnimatedSection(
                      animation: _confidenceAnimation,
                      child: ConfidenceScoreCard(
                        score: _result.confidenceScore,
                        animation: _confidenceAnimation,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _AnimatedSection(
                      animation: _recommendationAnimation,
                      child: RecommendationCard(
                        recommendation: _result.recommendation,
                        animation: _recommendationAnimation,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _AnimatedSection(
                      animation: _prosConsAnimation,
                      child: ProsConsSection(
                        pros: _result.pros,
                        cons: _result.cons,
                        animation: _prosConsAnimation,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _AnimatedSection(
                      animation: _actionAnimation,
                      child: ResultActionBar(
                        analysisText: _buildAnalysisText(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildFooter(theme, colorScheme),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _result.decisionTitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              size: 14,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 6),
            Text(
              'Analyzed with ${_result.usedModel}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              _isExisting ? _formatDateTime(_analyzedAt) : 'Just now',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooter(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.shield_rounded,
          size: 14,
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 6),
        Text(
          'Analysis is for reference purposes',
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  String _buildAnalysisText() {
    final buffer = StringBuffer();
    buffer.writeln('Decision Analysis: ${_result.decisionTitle}');
    buffer.writeln('Confidence: ${(_result.confidenceScore * 100).round()}%');
    buffer.writeln();
    buffer.writeln('Recommendation:');
    buffer.writeln(_result.recommendation);
    buffer.writeln();
    buffer.writeln('Pros:');
    for (final pro in _result.pros) {
      buffer.writeln('- $pro');
    }
    buffer.writeln();
    buffer.writeln('Cons:');
    for (final con in _result.cons) {
      buffer.writeln('- $con');
    }
    buffer.writeln();
    buffer.writeln(_result.summary);
    return buffer.toString();
  }
}

class _AnimatedSection extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _AnimatedSection({
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.06),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
