import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'DecisionAI'**
  String get appName;

  /// No description provided for @appNameUpper.
  ///
  /// In en, this message translates to:
  /// **'DECISION AI'**
  String get appNameUpper;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Smarter Decisions,\nPowered by AI'**
  String get splashTagline;

  /// No description provided for @onboardingPage1Title.
  ///
  /// In en, this message translates to:
  /// **'AI-Powered Analysis'**
  String get onboardingPage1Title;

  /// No description provided for @onboardingPage1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Get comprehensive analysis of your decisions with pros, cons, risks, and confidence scoring from leading AI models.'**
  String get onboardingPage1Subtitle;

  /// No description provided for @onboardingPage2Title.
  ///
  /// In en, this message translates to:
  /// **'Multi-Model Consensus'**
  String get onboardingPage2Title;

  /// No description provided for @onboardingPage2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Compare insights from GPT-4o, Claude 3.5, Gemini Pro, and DeepSeek to get a well-rounded perspective.'**
  String get onboardingPage2Subtitle;

  /// No description provided for @onboardingPage3Title.
  ///
  /// In en, this message translates to:
  /// **'Premium Features'**
  String get onboardingPage3Title;

  /// No description provided for @onboardingPage3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock unlimited analyses, PDF exports, ad-free experience, and priority AI processing with a Premium subscription.'**
  String get onboardingPage3Subtitle;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'DecisionAI'**
  String get homeTitle;

  /// No description provided for @homeHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Make Smarter\nDecisions'**
  String get homeHeroTitle;

  /// No description provided for @homeHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Leverage AI-powered analysis to evaluate options and make confident, data-driven choices.'**
  String get homeHeroSubtitle;

  /// No description provided for @homeHeroBadge.
  ///
  /// In en, this message translates to:
  /// **'Powered by advanced analysis'**
  String get homeHeroBadge;

  /// No description provided for @homeNewDecision.
  ///
  /// In en, this message translates to:
  /// **'New Decision'**
  String get homeNewDecision;

  /// No description provided for @homeDecisionHistory.
  ///
  /// In en, this message translates to:
  /// **'Decision History'**
  String get homeDecisionHistory;

  /// No description provided for @homeRecentDecisions.
  ///
  /// In en, this message translates to:
  /// **'Recent Decisions'**
  String get homeRecentDecisions;

  /// No description provided for @homeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get homeViewAll;

  /// No description provided for @homeNoDecisions.
  ///
  /// In en, this message translates to:
  /// **'No decisions yet. Start a new analysis!'**
  String get homeNoDecisions;

  /// No description provided for @homeUpgradePlan.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Plan'**
  String get homeUpgradePlan;

  /// No description provided for @homeOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get homeOpenSettings;

  /// No description provided for @newDecisionTitle.
  ///
  /// In en, this message translates to:
  /// **'New Decision'**
  String get newDecisionTitle;

  /// No description provided for @newDecisionLabel.
  ///
  /// In en, this message translates to:
  /// **'Decision Title'**
  String get newDecisionLabel;

  /// No description provided for @newDecisionHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Investment Portfolio Strategy'**
  String get newDecisionHint;

  /// No description provided for @newDecisionDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Describe Your Decision'**
  String get newDecisionDescriptionLabel;

  /// No description provided for @newDecisionDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'I need to decide between investing in tech stocks vs bonds...'**
  String get newDecisionDescriptionHint;

  /// No description provided for @newDecisionCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Decision Category'**
  String get newDecisionCategoryLabel;

  /// No description provided for @newDecisionCategoryHint.
  ///
  /// In en, this message translates to:
  /// **'Select the category that best fits your decision'**
  String get newDecisionCategoryHint;

  /// No description provided for @newDecisionModelLabel.
  ///
  /// In en, this message translates to:
  /// **'AI Model'**
  String get newDecisionModelLabel;

  /// No description provided for @newDecisionAnalyze.
  ///
  /// In en, this message translates to:
  /// **'Analyze Decision'**
  String get newDecisionAnalyze;

  /// No description provided for @analysisTitle.
  ///
  /// In en, this message translates to:
  /// **'Decision Analysis'**
  String get analysisTitle;

  /// No description provided for @analysisAnalyzing.
  ///
  /// In en, this message translates to:
  /// **'Analyzing your decision...'**
  String get analysisAnalyzing;

  /// No description provided for @analysisPleaseWait.
  ///
  /// In en, this message translates to:
  /// **'This may take a moment'**
  String get analysisPleaseWait;

  /// No description provided for @analysisInsufficientCredits.
  ///
  /// In en, this message translates to:
  /// **'Insufficient Credits'**
  String get analysisInsufficientCredits;

  /// No description provided for @analysisFailed.
  ///
  /// In en, this message translates to:
  /// **'Analysis Failed'**
  String get analysisFailed;

  /// No description provided for @analysisCreditError.
  ///
  /// In en, this message translates to:
  /// **'You have no credits remaining. Watch a rewarded ad or upgrade your plan to continue.'**
  String get analysisCreditError;

  /// No description provided for @analysisNoApiKey.
  ///
  /// In en, this message translates to:
  /// **'No API key configured for {model}. Go to Settings to add your key.'**
  String analysisNoApiKey(Object model);

  /// No description provided for @analysisRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get analysisRetry;

  /// No description provided for @analysisUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Plan'**
  String get analysisUpgrade;

  /// No description provided for @analysisRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Recommendation'**
  String get analysisRecommendation;

  /// No description provided for @analysisBestChoice.
  ///
  /// In en, this message translates to:
  /// **'Best Choice'**
  String get analysisBestChoice;

  /// No description provided for @analysisConfidence.
  ///
  /// In en, this message translates to:
  /// **'Confidence'**
  String get analysisConfidence;

  /// No description provided for @analysisHighlyConfident.
  ///
  /// In en, this message translates to:
  /// **'Highly Confident'**
  String get analysisHighlyConfident;

  /// No description provided for @analysisModeratelyConfident.
  ///
  /// In en, this message translates to:
  /// **'Moderately Confident'**
  String get analysisModeratelyConfident;

  /// No description provided for @analysisLowConfidence.
  ///
  /// In en, this message translates to:
  /// **'Low Confidence'**
  String get analysisLowConfidence;

  /// No description provided for @analysisPros.
  ///
  /// In en, this message translates to:
  /// **'Pros'**
  String get analysisPros;

  /// No description provided for @analysisCons.
  ///
  /// In en, this message translates to:
  /// **'Cons'**
  String get analysisCons;

  /// No description provided for @analysisRisks.
  ///
  /// In en, this message translates to:
  /// **'Risks to Consider'**
  String get analysisRisks;

  /// No description provided for @analysisReasoning.
  ///
  /// In en, this message translates to:
  /// **'Analysis Reasoning'**
  String get analysisReasoning;

  /// No description provided for @analysisCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get analysisCopy;

  /// No description provided for @analysisShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get analysisShare;

  /// No description provided for @analysisExportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get analysisExportPdf;

  /// No description provided for @analysisExporting.
  ///
  /// In en, this message translates to:
  /// **'Exporting...'**
  String get analysisExporting;

  /// No description provided for @analysisCopied.
  ///
  /// In en, this message translates to:
  /// **'Analysis copied to clipboard'**
  String get analysisCopied;

  /// No description provided for @analysisShareSoon.
  ///
  /// In en, this message translates to:
  /// **'Share functionality coming soon'**
  String get analysisShareSoon;

  /// No description provided for @analysisPdfSaved.
  ///
  /// In en, this message translates to:
  /// **'PDF saved as {fileName}'**
  String analysisPdfSaved(Object fileName);

  /// No description provided for @analysisPdfFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save PDF. Try a different browser.'**
  String get analysisPdfFailed;

  /// No description provided for @analysisPdfExportFailed.
  ///
  /// In en, this message translates to:
  /// **'PDF export failed: {error}'**
  String analysisPdfExportFailed(Object error);

  /// No description provided for @analysisFooter.
  ///
  /// In en, this message translates to:
  /// **'Analysis is for reference purposes'**
  String get analysisFooter;

  /// No description provided for @analysisAnalyzedWith.
  ///
  /// In en, this message translates to:
  /// **'Analyzed with {model}'**
  String analysisAnalyzedWith(Object model);

  /// No description provided for @analysisJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get analysisJustNow;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'Decision History'**
  String get historyTitle;

  /// No description provided for @historySearch.
  ///
  /// In en, this message translates to:
  /// **'Search decisions...'**
  String get historySearch;

  /// No description provided for @historyNoDecisions.
  ///
  /// In en, this message translates to:
  /// **'No decisions yet'**
  String get historyNoDecisions;

  /// No description provided for @historyNoDecisionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your analyzed decisions will appear here.\nStart by analyzing your first decision!'**
  String get historyNoDecisionsSubtitle;

  /// No description provided for @historyDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Decision'**
  String get historyDeleteTitle;

  /// No description provided for @historyDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this decision? This action cannot be undone.'**
  String get historyDeleteMessage;

  /// No description provided for @historyCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get historyCancel;

  /// No description provided for @historyDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get historyDelete;

  /// No description provided for @historyAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get historyAll;

  /// No description provided for @historyOldestFirst.
  ///
  /// In en, this message translates to:
  /// **'Oldest first'**
  String get historyOldestFirst;

  /// No description provided for @historyNewestFirst.
  ///
  /// In en, this message translates to:
  /// **'Newest first'**
  String get historyNewestFirst;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsAiModel.
  ///
  /// In en, this message translates to:
  /// **'AI Model'**
  String get settingsAiModel;

  /// No description provided for @settingsDefaultModel.
  ///
  /// In en, this message translates to:
  /// **'Default AI Model'**
  String get settingsDefaultModel;

  /// No description provided for @settingsDefaultModelHint.
  ///
  /// In en, this message translates to:
  /// **'Pre-selected model when creating a new decision'**
  String get settingsDefaultModelHint;

  /// No description provided for @settingsApiKeys.
  ///
  /// In en, this message translates to:
  /// **'API Keys'**
  String get settingsApiKeys;

  /// No description provided for @settingsApiKeysHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your API keys for each provider. Keys are stored securely on your device.'**
  String get settingsApiKeysHint;

  /// No description provided for @settingsApiKeyHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your {provider} API key'**
  String settingsApiKeyHint(Object provider);

  /// No description provided for @settingsSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settingsSave;

  /// No description provided for @settingsDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get settingsDelete;

  /// No description provided for @settingsKeySaved.
  ///
  /// In en, this message translates to:
  /// **'{provider} key saved'**
  String settingsKeySaved(Object provider);

  /// No description provided for @settingsKeyDeleted.
  ///
  /// In en, this message translates to:
  /// **'{provider} key deleted'**
  String settingsKeyDeleted(Object provider);

  /// No description provided for @settingsDeleteKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete API Key'**
  String get settingsDeleteKeyTitle;

  /// No description provided for @settingsDeleteKeyMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove {provider} API key?'**
  String settingsDeleteKeyMessage(Object provider);

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsLight;

  /// No description provided for @settingsDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsDark;

  /// No description provided for @settingsSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsSystem;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settingsVersion(Object version);

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Your API keys are stored securely on your device using encrypted storage. No data is collected or transmitted to third parties. All AI analysis requests are sent directly to the chosen provider.'**
  String get settingsPrivacy;

  /// No description provided for @upgradeTitle.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Plan'**
  String get upgradeTitle;

  /// No description provided for @upgradeChoosePlan.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Plan'**
  String get upgradeChoosePlan;

  /// No description provided for @upgradeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock more analyses and premium features'**
  String get upgradeSubtitle;

  /// No description provided for @upgradeCurrentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get upgradeCurrentPlan;

  /// No description provided for @upgradeSubscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get upgradeSubscribe;

  /// No description provided for @upgradeDowngrade.
  ///
  /// In en, this message translates to:
  /// **'Downgrade'**
  String get upgradeDowngrade;

  /// No description provided for @upgradeRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get upgradeRestore;

  /// No description provided for @upgradeBestValue.
  ///
  /// In en, this message translates to:
  /// **'BEST VALUE'**
  String get upgradeBestValue;

  /// No description provided for @freeTierName.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get freeTierName;

  /// No description provided for @freeTierFeature1.
  ///
  /// In en, this message translates to:
  /// **'10 free analyses'**
  String get freeTierFeature1;

  /// No description provided for @freeTierFeature2.
  ///
  /// In en, this message translates to:
  /// **'Ads supported'**
  String get freeTierFeature2;

  /// No description provided for @freeTierFeature3.
  ///
  /// In en, this message translates to:
  /// **'Basic AI analysis'**
  String get freeTierFeature3;

  /// No description provided for @freeTierLimit1.
  ///
  /// In en, this message translates to:
  /// **'No PDF export'**
  String get freeTierLimit1;

  /// No description provided for @freeTierLimit2.
  ///
  /// In en, this message translates to:
  /// **'No priority AI'**
  String get freeTierLimit2;

  /// No description provided for @premiumTierName.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premiumTierName;

  /// No description provided for @premiumTierPrice.
  ///
  /// In en, this message translates to:
  /// **'\$9.99/mo'**
  String get premiumTierPrice;

  /// No description provided for @premiumTierFeature1.
  ///
  /// In en, this message translates to:
  /// **'300 analyses/month'**
  String get premiumTierFeature1;

  /// No description provided for @premiumTierFeature2.
  ///
  /// In en, this message translates to:
  /// **'PDF export'**
  String get premiumTierFeature2;

  /// No description provided for @premiumTierFeature3.
  ///
  /// In en, this message translates to:
  /// **'No ads'**
  String get premiumTierFeature3;

  /// No description provided for @premiumTierFeature4.
  ///
  /// In en, this message translates to:
  /// **'Standard AI models'**
  String get premiumTierFeature4;

  /// No description provided for @proTierName.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get proTierName;

  /// No description provided for @proTierPrice.
  ///
  /// In en, this message translates to:
  /// **'\$19.99/mo'**
  String get proTierPrice;

  /// No description provided for @proTierFeature1.
  ///
  /// In en, this message translates to:
  /// **'Unlimited analyses'**
  String get proTierFeature1;

  /// No description provided for @proTierFeature2.
  ///
  /// In en, this message translates to:
  /// **'Unlimited PDF export'**
  String get proTierFeature2;

  /// No description provided for @proTierFeature3.
  ///
  /// In en, this message translates to:
  /// **'Priority AI processing'**
  String get proTierFeature3;

  /// No description provided for @proTierFeature4.
  ///
  /// In en, this message translates to:
  /// **'Future premium models'**
  String get proTierFeature4;

  /// No description provided for @notificationDailyReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Decision Check-in'**
  String get notificationDailyReminderTitle;

  /// No description provided for @notificationDailyReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Have you thought about that important decision today? Let DecisionAI help you analyze it!'**
  String get notificationDailyReminderBody;

  /// No description provided for @notificationDecisionReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Decision Reminder'**
  String get notificationDecisionReminderTitle;

  /// No description provided for @notificationDecisionReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Remember to review your decision analysis for \"{title}\"'**
  String notificationDecisionReminderBody(Object title);

  /// No description provided for @notificationChannelDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily Reminders'**
  String get notificationChannelDaily;

  /// No description provided for @notificationChannelDecision.
  ///
  /// In en, this message translates to:
  /// **'Decision Reminders'**
  String get notificationChannelDecision;

  /// No description provided for @creditTrackerCredits.
  ///
  /// In en, this message translates to:
  /// **'cr'**
  String get creditTrackerCredits;

  /// No description provided for @creditTrackerMonthly.
  ///
  /// In en, this message translates to:
  /// **'mo'**
  String get creditTrackerMonthly;

  /// No description provided for @creditTrackerFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get creditTrackerFree;

  /// No description provided for @creditTrackerPremium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get creditTrackerPremium;

  /// No description provided for @creditTrackerPro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get creditTrackerPro;

  /// No description provided for @decisionTypePersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get decisionTypePersonal;

  /// No description provided for @decisionTypeCareer.
  ///
  /// In en, this message translates to:
  /// **'Career'**
  String get decisionTypeCareer;

  /// No description provided for @decisionTypeBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get decisionTypeBusiness;

  /// No description provided for @decisionTypeFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get decisionTypeFinance;

  /// No description provided for @decisionTypeHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get decisionTypeHealth;

  /// No description provided for @decisionTypeEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get decisionTypeEducation;

  /// No description provided for @decisionTypeTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get decisionTypeTravel;

  /// No description provided for @decisionTypeRelationship.
  ///
  /// In en, this message translates to:
  /// **'Relationship'**
  String get decisionTypeRelationship;

  /// No description provided for @decisionTypeCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get decisionTypeCustom;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
