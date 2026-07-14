import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/analysis_result/presentation/screens/analysis_result_screen.dart';
import '../../features/history/presentation/screens/history_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/monetization/presentation/screens/upgrade_screen.dart';
import '../../features/new_decision/presentation/screens/new_decision_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../database/models/decision_record.dart';
import 'routes.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.newDecision,
        name: 'newDecision',
        builder: (context, state) => const NewDecisionScreen(),
      ),
      GoRoute(
        path: AppRoutes.analysisResult,
        name: 'analysisResult',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final record = extra?['record'] as DecisionRecord?;
          return AnalysisResultScreen(
            title: record?.title ?? extra?['title'] as String?,
            description:
                record?.description ?? extra?['description'] as String?,
            model: record?.model ?? extra?['model'] as String?,
            existingRecord: record,
            decisionType: extra?['decisionType'] as String?,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.history,
        name: 'history',
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.upgrade,
        name: 'upgrade',
        builder: (context, state) => const UpgradeScreen(),
      ),
    ],
  );
}
