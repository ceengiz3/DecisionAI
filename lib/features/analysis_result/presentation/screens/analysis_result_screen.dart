import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/isar_database.dart';
import '../../../../core/database/models/decision_record.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/domain/enums/ai_provider_type.dart';
import '../../../../core/domain/models/analysis_result.dart';
import '../widgets/confidence_score_card.dart';
import '../widgets/pros_cons_section.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/result_action_bar.dart';

class AnalysisResultScreen extends ConsumerStatefulWidget {
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
  ConsumerState<AnalysisResultScreen> createState() =>
      _AnalysisResultScreenState();
}

class _AnalysisResultScreenState
    extends ConsumerState<AnalysisResultScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _confidenceAnimation;
  Animation<double>? _recommendationAnimation;
  Animation<double>? _prosConsAnimation;
  Animation<double>? _actionAnimation;

  AnalysisResult? _result;
  String? _error;
  bool _isLoading = false;
  bool _isExisting = false;
  late DateTime _analyzedAt;

  @override
  void initState() {
    super.initState();
    _analyzedAt = DateTime.now();

    if (widget.existingRecord != null) {
      _loadFromRecord();
    } else {
      _analyze();
    }
  }

  void _loadFromRecord() {
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
    _initAnimations();
  }

  Future<void> _analyze() async {
    setState(() => _isLoading = true);

    try {
      final title = widget.title?.isNotEmpty == true
          ? widget.title!
          : 'Untitled Decision';
      final description = widget.description ?? '';
      final modelName = widget.model ?? 'GPT-4o';
      final providerType = AiProviderType.fromDisplayName(modelName);

      final storage = ref.read(apiKeyStorageProvider);
      final apiKey = await storage.getApiKey(providerType);

      if (apiKey == null || apiKey.isEmpty) {
        setState(() {
          _error =
              'No API key configured for ${providerType.displayName}. '
              'Go to Settings to add your key.';
          _isLoading = false;
        });
        return;
      }

      final service = ref.read(analysisServiceProvider);
      final result = await service.analyze(
        title: title,
        description: description,
        providerType: providerType,
        apiKey: apiKey,
      );

      setState(() {
        _result = result;
        _isLoading = false;
      });

      _initAnimations();
      _saveToIsar(result, modelName);
    } catch (e) {
      setState(() {
        _error = 'Analysis failed: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _initAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _confidenceAnimation = CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
    );
    _recommendationAnimation = CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0.15, 0.5, curve: Curves.easeOutCubic),
    );
    _prosConsAnimation = CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0.3, 0.65, curve: Curves.easeOutCubic),
    );
    _actionAnimation = CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0.5, 0.8, curve: Curves.easeOutCubic),
    );
    _controller!.forward();
  }

  Future<void> _saveToIsar(AnalysisResult result, String modelName) async {
    final record = DecisionRecord()
      ..title = widget.title?.isNotEmpty == true ? widget.title : null
      ..description = widget.description ?? ''
      ..model = modelName
      ..confidenceScore = result.confidenceScore
      ..recommendation = result.recommendation
      ..prosJson = jsonEncode(result.pros)
      ..consJson = jsonEncode(result.cons)
      ..summary = result.summary
      ..createdAt = _analyzedAt;
    await IsarDatabase.saveDecision(record);
  }

  @override
  void dispose() {
    _controller?.dispose();
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
                child: _buildBody(theme, colorScheme),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(ThemeData theme, ColorScheme colorScheme) {
    if (_isLoading) {
      return _buildLoadingState(theme, colorScheme);
    }
    if (_error != null) {
      return _buildErrorState(theme, colorScheme);
    }
    if (_result == null) {
      return const SizedBox.shrink();
    }
    return _buildContent(theme, colorScheme);
  }

  Widget _buildLoadingState(ThemeData theme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: colorScheme.primary),
          const SizedBox(height: 24),
          Text(
            'Analyzing your decision...',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This may take a moment',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 48,
            color: colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Analysis Failed',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _error!,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.tonalIcon(
            onPressed: () {
              setState(() {
                _error = null;
                _result = null;
              });
              _analyze();
            },
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(ThemeData theme, ColorScheme colorScheme) {
    final r = _result!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(theme, colorScheme, r),
        const SizedBox(height: 20),
        _AnimatedSection(
          animation: _confidenceAnimation!,
          child: ConfidenceScoreCard(
            score: r.confidenceScore,
            animation: _confidenceAnimation!,
          ),
        ),
        const SizedBox(height: 20),
        _AnimatedSection(
          animation: _recommendationAnimation!,
          child: RecommendationCard(
            recommendation: r.recommendation,
            animation: _recommendationAnimation!,
          ),
        ),
        const SizedBox(height: 20),
        _AnimatedSection(
          animation: _prosConsAnimation!,
          child: ProsConsSection(
            pros: r.pros,
            cons: r.cons,
            animation: _prosConsAnimation!,
          ),
        ),
        const SizedBox(height: 24),
        _AnimatedSection(
          animation: _actionAnimation!,
          child: ResultActionBar(
            analysisText: _buildAnalysisText(r),
          ),
        ),
        const SizedBox(height: 12),
        _buildFooter(theme, colorScheme),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildHeader(
    ThemeData theme,
    ColorScheme colorScheme,
    AnalysisResult r,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          r.decisionTitle,
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
              'Analyzed with ${r.usedModel}',
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

  String _buildAnalysisText(AnalysisResult r) {
    final buffer = StringBuffer();
    buffer.writeln('Decision Analysis: ${r.decisionTitle}');
    buffer.writeln('Confidence: ${(r.confidenceScore * 100).round()}%');
    buffer.writeln();
    buffer.writeln('Recommendation:');
    buffer.writeln(r.recommendation);
    buffer.writeln();
    buffer.writeln('Pros:');
    for (final pro in r.pros) {
      buffer.writeln('- $pro');
    }
    buffer.writeln();
    buffer.writeln('Cons:');
    for (final con in r.cons) {
      buffer.writeln('- $con');
    }
    buffer.writeln();
    buffer.writeln(r.summary);
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
