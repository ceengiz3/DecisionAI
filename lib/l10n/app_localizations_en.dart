// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'DecisionAI';

  @override
  String get appNameUpper => 'DECISION AI';

  @override
  String get splashTagline => 'Smarter Decisions,\nPowered by AI';

  @override
  String get onboardingPage1Title => 'AI-Powered Analysis';

  @override
  String get onboardingPage1Subtitle =>
      'Get comprehensive analysis of your decisions with pros, cons, risks, and confidence scoring from leading AI models.';

  @override
  String get onboardingPage2Title => 'Multi-Model Consensus';

  @override
  String get onboardingPage2Subtitle =>
      'Compare insights from GPT-4o, Claude 3.5, Gemini Pro, and DeepSeek to get a well-rounded perspective.';

  @override
  String get onboardingPage3Title => 'Premium Features';

  @override
  String get onboardingPage3Subtitle =>
      'Unlock unlimited analyses, PDF exports, ad-free experience, and priority AI processing with a Premium subscription.';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get homeTitle => 'DecisionAI';

  @override
  String get homeHeroTitle => 'Make Smarter\nDecisions';

  @override
  String get homeHeroSubtitle =>
      'Leverage AI-powered analysis to evaluate options and make confident, data-driven choices.';

  @override
  String get homeHeroBadge => 'Powered by advanced analysis';

  @override
  String get homeNewDecision => 'New Decision';

  @override
  String get homeDecisionHistory => 'Decision History';

  @override
  String get homeRecentDecisions => 'Recent Decisions';

  @override
  String get homeViewAll => 'View All';

  @override
  String get homeNoDecisions => 'No decisions yet. Start a new analysis!';

  @override
  String get homeUpgradePlan => 'Upgrade Plan';

  @override
  String get homeOpenSettings => 'Open Settings';

  @override
  String get newDecisionTitle => 'New Decision';

  @override
  String get newDecisionLabel => 'Decision Title';

  @override
  String get newDecisionHint => 'e.g. Investment Portfolio Strategy';

  @override
  String get newDecisionDescriptionLabel => 'Describe Your Decision';

  @override
  String get newDecisionDescriptionHint =>
      'I need to decide between investing in tech stocks vs bonds...';

  @override
  String get newDecisionCategoryLabel => 'Decision Category';

  @override
  String get newDecisionCategoryHint =>
      'Select the category that best fits your decision';

  @override
  String get newDecisionModelLabel => 'AI Model';

  @override
  String get newDecisionAnalyze => 'Analyze Decision';

  @override
  String get analysisTitle => 'Decision Analysis';

  @override
  String get analysisAnalyzing => 'Analyzing your decision...';

  @override
  String get analysisPleaseWait => 'This may take a moment';

  @override
  String get analysisInsufficientCredits => 'Insufficient Credits';

  @override
  String get analysisFailed => 'Analysis Failed';

  @override
  String get analysisCreditError =>
      'You have no credits remaining. Watch a rewarded ad or upgrade your plan to continue.';

  @override
  String analysisNoApiKey(Object model) {
    return 'No API key configured for $model. Go to Settings to add your key.';
  }

  @override
  String get analysisRetry => 'Retry';

  @override
  String get analysisUpgrade => 'Upgrade Plan';

  @override
  String get analysisRecommendation => 'Recommendation';

  @override
  String get analysisBestChoice => 'Best Choice';

  @override
  String get analysisConfidence => 'Confidence';

  @override
  String get analysisHighlyConfident => 'Highly Confident';

  @override
  String get analysisModeratelyConfident => 'Moderately Confident';

  @override
  String get analysisLowConfidence => 'Low Confidence';

  @override
  String get analysisPros => 'Pros';

  @override
  String get analysisCons => 'Cons';

  @override
  String get analysisRisks => 'Risks to Consider';

  @override
  String get analysisReasoning => 'Analysis Reasoning';

  @override
  String get analysisCopy => 'Copy';

  @override
  String get analysisShare => 'Share';

  @override
  String get analysisExportPdf => 'Export PDF';

  @override
  String get analysisExporting => 'Exporting...';

  @override
  String get analysisCopied => 'Analysis copied to clipboard';

  @override
  String get analysisShareSoon => 'Share functionality coming soon';

  @override
  String analysisPdfSaved(Object fileName) {
    return 'PDF saved as $fileName';
  }

  @override
  String get analysisPdfFailed =>
      'Could not save PDF. Try a different browser.';

  @override
  String analysisPdfExportFailed(Object error) {
    return 'PDF export failed: $error';
  }

  @override
  String get analysisFooter => 'Analysis is for reference purposes';

  @override
  String analysisAnalyzedWith(Object model) {
    return 'Analyzed with $model';
  }

  @override
  String get analysisJustNow => 'Just now';

  @override
  String get historyTitle => 'Decision History';

  @override
  String get historySearch => 'Search decisions...';

  @override
  String get historyNoDecisions => 'No decisions yet';

  @override
  String get historyNoDecisionsSubtitle =>
      'Your analyzed decisions will appear here.\nStart by analyzing your first decision!';

  @override
  String get historyDeleteTitle => 'Delete Decision';

  @override
  String get historyDeleteMessage =>
      'Are you sure you want to delete this decision? This action cannot be undone.';

  @override
  String get historyCancel => 'Cancel';

  @override
  String get historyDelete => 'Delete';

  @override
  String get historyAll => 'All';

  @override
  String get historyOldestFirst => 'Oldest first';

  @override
  String get historyNewestFirst => 'Newest first';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsAiModel => 'AI Model';

  @override
  String get settingsDefaultModel => 'Default AI Model';

  @override
  String get settingsDefaultModelHint =>
      'Pre-selected model when creating a new decision';

  @override
  String get settingsApiKeys => 'API Keys';

  @override
  String get settingsApiKeysHint =>
      'Enter your API keys for each provider. Keys are stored securely on your device.';

  @override
  String settingsApiKeyHint(Object provider) {
    return 'Enter your $provider API key';
  }

  @override
  String get settingsSave => 'Save';

  @override
  String get settingsDelete => 'Delete';

  @override
  String settingsKeySaved(Object provider) {
    return '$provider key saved';
  }

  @override
  String settingsKeyDeleted(Object provider) {
    return '$provider key deleted';
  }

  @override
  String get settingsDeleteKeyTitle => 'Delete API Key';

  @override
  String settingsDeleteKeyMessage(Object provider) {
    return 'Remove $provider API key?';
  }

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsLight => 'Light';

  @override
  String get settingsDark => 'Dark';

  @override
  String get settingsSystem => 'System';

  @override
  String get settingsAbout => 'About';

  @override
  String settingsVersion(Object version) {
    return 'Version $version';
  }

  @override
  String get settingsPrivacy =>
      'Your API keys are stored securely on your device using encrypted storage. No data is collected or transmitted to third parties. All AI analysis requests are sent directly to the chosen provider.';

  @override
  String get upgradeTitle => 'Upgrade Plan';

  @override
  String get upgradeChoosePlan => 'Choose Your Plan';

  @override
  String get upgradeSubtitle => 'Unlock more analyses and premium features';

  @override
  String get upgradeCurrentPlan => 'Current Plan';

  @override
  String get upgradeSubscribe => 'Subscribe';

  @override
  String get upgradeDowngrade => 'Downgrade';

  @override
  String get upgradeRestore => 'Restore Purchases';

  @override
  String get upgradeBestValue => 'BEST VALUE';

  @override
  String get freeTierName => 'Free';

  @override
  String get freeTierFeature1 => '10 free analyses';

  @override
  String get freeTierFeature2 => 'Ads supported';

  @override
  String get freeTierFeature3 => 'Basic AI analysis';

  @override
  String get freeTierLimit1 => 'No PDF export';

  @override
  String get freeTierLimit2 => 'No priority AI';

  @override
  String get premiumTierName => 'Premium';

  @override
  String get premiumTierPrice => '\$9.99/mo';

  @override
  String get premiumTierFeature1 => '300 analyses/month';

  @override
  String get premiumTierFeature2 => 'PDF export';

  @override
  String get premiumTierFeature3 => 'No ads';

  @override
  String get premiumTierFeature4 => 'Standard AI models';

  @override
  String get proTierName => 'Pro';

  @override
  String get proTierPrice => '\$19.99/mo';

  @override
  String get proTierFeature1 => 'Unlimited analyses';

  @override
  String get proTierFeature2 => 'Unlimited PDF export';

  @override
  String get proTierFeature3 => 'Priority AI processing';

  @override
  String get proTierFeature4 => 'Future premium models';

  @override
  String get notificationDailyReminderTitle => 'Daily Decision Check-in';

  @override
  String get notificationDailyReminderBody =>
      'Have you thought about that important decision today? Let DecisionAI help you analyze it!';

  @override
  String get notificationDecisionReminderTitle => 'Decision Reminder';

  @override
  String notificationDecisionReminderBody(Object title) {
    return 'Remember to review your decision analysis for \"$title\"';
  }

  @override
  String get notificationChannelDaily => 'Daily Reminders';

  @override
  String get notificationChannelDecision => 'Decision Reminders';

  @override
  String get creditTrackerCredits => 'cr';

  @override
  String get creditTrackerMonthly => 'mo';

  @override
  String get creditTrackerFree => 'Free';

  @override
  String get creditTrackerPremium => 'Premium';

  @override
  String get creditTrackerPro => 'Pro';

  @override
  String get decisionTypePersonal => 'Personal';

  @override
  String get decisionTypeCareer => 'Career';

  @override
  String get decisionTypeBusiness => 'Business';

  @override
  String get decisionTypeFinance => 'Finance';

  @override
  String get decisionTypeHealth => 'Health';

  @override
  String get decisionTypeEducation => 'Education';

  @override
  String get decisionTypeTravel => 'Travel';

  @override
  String get decisionTypeRelationship => 'Relationship';

  @override
  String get decisionTypeCustom => 'Custom';
}
