import 'dart:math';
import 'package:flutter/material.dart';

class ConfidenceScoreCard extends StatelessWidget {
  final double score;
  final Animation<double> animation;

  const ConfidenceScoreCard({
    super.key,
    required this.score,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final color = score >= 0.8
        ? const Color(0xFF2E7D32)
        : score >= 0.6
            ? const Color(0xFFE65100)
            : const Color(0xFFC62828);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
        child: Column(
          children: [
            SizedBox(
              width: 170,
              height: 170,
              child: CustomPaint(
                painter: _ConfidenceArcPainter(
                  score: score,
                  animationValue: animation.value,
                  color: color,
                  backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${(score * 100).round()}%',
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Confidence',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                score >= 0.8
                    ? 'Highly Confident'
                    : score >= 0.6
                        ? 'Moderately Confident'
                        : 'Low Confidence',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfidenceArcPainter extends CustomPainter {
  final double score;
  final double animationValue;
  final Color color;
  final Color backgroundColor;

  _ConfidenceArcPainter({
    required this.score,
    required this.animationValue,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 16;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * pi * score * animationValue;
    if (sweepAngle > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        sweepAngle,
        false,
        fgPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ConfidenceArcPainter old) {
    return old.score != score ||
        old.animationValue != animationValue ||
        old.color != color;
  }
}
