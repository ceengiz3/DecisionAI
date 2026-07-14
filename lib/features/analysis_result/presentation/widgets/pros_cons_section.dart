import 'package:flutter/material.dart';

class ProsConsSection extends StatelessWidget {
  final List<String> pros;
  final List<String> cons;
  final Animation<double> animation;

  const ProsConsSection({
    super.key,
    required this.pros,
    required this.cons,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 500;

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildColumn(theme, colorScheme, pros, true)),
              const SizedBox(width: 16),
              Expanded(child: _buildColumn(theme, colorScheme, cons, false)),
            ],
          );
        }

        return Column(
          children: [
            _buildColumn(theme, colorScheme, pros, true),
            const SizedBox(height: 16),
            _buildColumn(theme, colorScheme, cons, false),
          ],
        );
      },
    );
  }

  Widget _buildColumn(
    ThemeData theme,
    ColorScheme colorScheme,
    List<String> items,
    bool isPro,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isPro ? Icons.check_circle_rounded : Icons.cancel_rounded,
              size: 20,
              color: isPro
                  ? const Color(0xFF2E7D32)
                  : const Color(0xFFC62828),
            ),
            const SizedBox(width: 8),
            Text(
              isPro ? 'Pros' : 'Cons',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...List.generate(items.length, (index) {
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
                    color: isPro
                        ? const Color(0xFF2E7D32).withValues(alpha: 0.12)
                        : const Color(0xFFC62828).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    isPro ? Icons.check_rounded : Icons.close_rounded,
                    size: 14,
                    color: isPro
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFC62828),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    items[index],
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
    );
  }
}
