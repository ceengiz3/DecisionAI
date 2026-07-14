import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/isar_database.dart';
import '../../../../core/database/models/decision_record.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/domain/enums/ai_provider_type.dart';
import '../../../../core/domain/enums/decision_type.dart';
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
  final String? decisionType;

  const AnalysisResultScreen({
    super.key,
    this.title,
    this.description,
    this.model,
    this.existingRecord,
    this.decisionType,
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
  Animation<double>? _risksAnimation;
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
      risks: r.risks,
      bestChoice: r.bestChoice,
      reasoning: r.reasoning,
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
      final decisionTypeName = widget.decisionType ?? 'custom';
      final decisionType = DecisionType.values.firstWhere(
        (t) => t.name == decisionTypeName,
        orElse: () => DecisionType.custom,
      );

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
        decisionType: decisionType,
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
      duration: const Duration(milliseconds: 1400),
    );
    _confidenceAnimation = CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOutCubic),
    );
    _recommendationAnimation = CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0.12, 0.42, curve: Curves.easeOutCubic),
    );
    _prosConsAnimation = CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0.25, 0.55, curve: Curves.easeOutCubic),
    );
    _risksAnimation = CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0.38, 0.68, curve: Curves.easeOutCubic),
    );
    _actionAnimation = CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0.52, 0.82, curve: Curves.easeOutCubic),
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
    if (result.risks.isNotEmpty) {
      record.risksJson = jsonEncode(result.risks);
    }
    if (result.bestChoice != null) {
      record.bestChoice = result.bestChoice;
    }
    if (result.reasoning != null) {
      record.reasoning = result.reasoning;
    }
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
        if (r.bestChoice != null && r.bestChoice!.isNotEmpty) ...[
          const SizedBox(height: 20),
          _AnimatedSection(
            animation: _recommendationAnimation!,
            child: _BestChoiceCard(bestChoice: r.bestChoice!),
          ),
        ],
        const SizedBox(height: 20),
        _AnimatedSection(
          animation: _prosConsAnimation!,
          child: ProsConsSection(
            pros: r.pros,
            cons: r.cons,
            animation: _prosConsAnimation!,
          ),
        ),
        if (r.risks.isNotEmpty) ...[
          const SizedBox(height: 20),
          _AnimatedSection(
            animation: _risksAnimation!,
            child: _RisksSection(risks: r.risks),
          ),
        ],
        if (r.reasoning != null && r.reasoning!.isNotEmpty) ...[
          const SizedBox(height: 20),
          _AnimatedSection(
            animation: _risksAnimation!,
            child: _ReasoningCard(reasoning: r.reasoning!),
          ),
        ],
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
    if (r.bestChoice != null && r.bestChoice!.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('Best Choice: ${r.bestChoice}');
    }
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
    if (r.risks.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('Risks:');
      for (final risk in r.risks) {
        buffer.writeln('- $risk');
      }
    }
    buffer.writeln();
    buffer.writeln(r.summary);
    if (r.reasoning != null && r.reasoning!.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('Reasoning:');
      buffer.writeln(r.reasoning);
    }
    return buffer.toString();
  }
}

class _BestChoiceCard extends StatelessWidget {
  final String bestChoice;

  const _BestChoiceCard({required this.bestChoice});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.tertiaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.onTertiaryContainer.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.flag_rounded,
                color: colorScheme.onTertiaryContainer,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Best Choice',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onTertiaryContainer,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    bestChoice,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onTertiaryContainer
                          .withValues(alpha: 0.85),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RisksSection extends StatelessWidget {
  final List<String> risks;

  const _RisksSection({required this.risks});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  size: 20,
                  color: Color(0xFFE65100),
                ),
                const SizedBox(width: 8),
                Text(
                  'Risks to Consider',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...List.generate(risks.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE65100).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.priority_high_rounded,
                        size: 14,
                        color: Color(0xFFE65100),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        risks[index],
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _ReasoningCard extends StatelessWidget {
  final String reasoning;

  const _ReasoningCard({required this.reasoning});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.psychology_rounded,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Analysis Reasoning',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              reasoning,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
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
