import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../l10n/l10n.dart';
import '../../../monetization/presentation/widgets/usage_tracker_widget.dart';
import '../widgets/action_buttons.dart';
import '../widgets/hero_card.dart';
import '../widgets/recent_decisions_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _heroAnimation;
  late final Animation<double> _buttonsAnimation;
  late final Animation<double> _listAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _heroAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
    );
    _buttonsAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 0.5, curve: Curves.easeOutCubic),
    );
    _listAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.homeTitle),
        actions: [
          const UsageTrackerWidget(),
          const SizedBox(width: 4),
          IconButton(
            icon: const Icon(Icons.workspace_premium_outlined),
            tooltip: l.homeUpgradePlan,
            onPressed: () => context.go(AppRoutes.upgrade),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l.homeOpenSettings,
            onPressed: () => context.go(AppRoutes.settings),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Center(
              child: SizedBox(
                width: maxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FadeTransition(
                      opacity: _heroAnimation,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.85, end: 1.0)
                            .animate(_heroAnimation),
                        child: const HeroCard(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    FadeTransition(
                      opacity: _buttonsAnimation,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.9, end: 1.0)
                            .animate(_buttonsAnimation),
                        child: const ActionButtons(),
                      ),
                    ),
                    const SizedBox(height: 32),
                    FadeTransition(
                      opacity: _listAnimation,
                      child: RecentDecisionsSection(
                        parentAnimation: _controller,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
