import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/domain/enums/decision_type.dart';
import '../../../../core/router/routes.dart';
import '../widgets/model_selector.dart';

class NewDecisionScreen extends StatefulWidget {
  const NewDecisionScreen({super.key});

  @override
  State<NewDecisionScreen> createState() => _NewDecisionScreenState();
}

class _NewDecisionScreenState extends State<NewDecisionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _titleAnimation;
  late final Animation<double> _descriptionAnimation;
  late final Animation<double> _modelAnimation;
  late final Animation<double> _categoryAnimation;
  late final Animation<double> _buttonAnimation;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedModel = 'GPT-4o';
  DecisionType _selectedType = DecisionType.custom;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _titleAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.25, curve: Curves.easeOutCubic),
    );
    _descriptionAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.12, 0.38, curve: Curves.easeOutCubic),
    );
    _categoryAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.25, 0.52, curve: Curves.easeOutCubic),
    );
    _modelAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.38, 0.65, curve: Curves.easeOutCubic),
    );
    _buttonAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.52, 0.78, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('New Decision')),
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
                    _AnimatedFormField(
                      animation: _titleAnimation,
                      child: _buildTitleField(theme),
                    ),
                    const SizedBox(height: 20),
                    _AnimatedFormField(
                      animation: _descriptionAnimation,
                      child: _buildDescriptionField(theme),
                    ),
                    const SizedBox(height: 20),
                    _AnimatedFormField(
                      animation: _categoryAnimation,
                      child: _buildTypeSelector(theme),
                    ),
                    const SizedBox(height: 20),
                    _AnimatedFormField(
                      animation: _modelAnimation,
                      child: ModelSelector(
                        selectedModel: _selectedModel,
                        onModelChanged: (model) {
                          setState(() => _selectedModel = model);
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    _AnimatedFormField(
                      animation: _buttonAnimation,
                      child: _buildAnalyzeButton(theme),
                    ),
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

  Widget _buildTitleField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Decision Title',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Give your decision a name (optional)',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _titleController,
          decoration: InputDecoration(
            hintText: 'e.g. Investment Portfolio Strategy',
            hintStyle: TextStyle(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }

  Widget _buildDescriptionField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Describe Your Decision',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Provide context, options, and any relevant details',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _descriptionController,
          maxLines: 6,
          minLines: 4,
          decoration: InputDecoration(
            hintText:
                'I need to decide between investing in tech stocks vs bonds...',
            hintStyle: TextStyle(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.all(16),
            alignLabelWithHint: true,
          ),
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }

  Widget _buildTypeSelector(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Decision Category',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Select the category that best fits your decision',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<DecisionType>(
              value: _selectedType,
              isExpanded: true,
              items: DecisionType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.displayName),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedType = value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyzeButton(ThemeData theme) {
    return FilledButton.icon(
      onPressed: () => context.go(
        AppRoutes.analysisResult,
        extra: {
          'title': _titleController.text,
          'description': _descriptionController.text,
          'model': _selectedModel,
          'decisionType': _selectedType.name,
        },
      ),
      icon: const Icon(Icons.auto_awesome_rounded),
      label: const Text('Analyze Decision'),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 18),
        textStyle: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class _AnimatedFormField extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _AnimatedFormField({
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
