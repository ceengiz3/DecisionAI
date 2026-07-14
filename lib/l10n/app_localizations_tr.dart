// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'DecisionAI';

  @override
  String get appNameUpper => 'DECISION AI';

  @override
  String get splashTagline => 'Daha Akıllı Kararlar,\nYapay Zeka Destekli';

  @override
  String get onboardingPage1Title => 'Yapay Zeka Destekli Analiz';

  @override
  String get onboardingPage1Subtitle =>
      'Önde gelen yapay zeka modelleriyle kararlarınızın kapsamlı analizini alın: artılar, eksiler, riskler ve güven skorlaması.';

  @override
  String get onboardingPage2Title => 'Çoklu Model Fikir Birliği';

  @override
  String get onboardingPage2Subtitle =>
      'GPT-4o, Claude 3.5, Gemini Pro ve DeepSeek\'ten gelen içgörüleri karşılaştırarak çok yönlü bir perspektif elde edin.';

  @override
  String get onboardingPage3Title => 'Premium Özellikler';

  @override
  String get onboardingPage3Subtitle =>
      'Premium aboneliği ile sınırsız analiz, PDF dışa aktarma, reklamsız deneyim ve öncelikli yapay zeka işlemenin kilidini açın.';

  @override
  String get onboardingGetStarted => 'Başlayın';

  @override
  String get onboardingNext => 'İleri';

  @override
  String get onboardingSkip => 'Atla';

  @override
  String get homeTitle => 'DecisionAI';

  @override
  String get homeHeroTitle => 'Daha Akıllı\nKararlar';

  @override
  String get homeHeroSubtitle =>
      'Seçenekleri değerlendirmek ve kendinize güvenerek, veri odaklı kararlar almak için yapay zeka destekli analizden yararlanın.';

  @override
  String get homeHeroBadge => 'Gelişmiş analiz ile desteklenmektedir';

  @override
  String get homeNewDecision => 'Yeni Karar';

  @override
  String get homeDecisionHistory => 'Karar Geçmişi';

  @override
  String get homeRecentDecisions => 'Son Kararlar';

  @override
  String get homeViewAll => 'Tümünü Gör';

  @override
  String get homeNoDecisions => 'Henüz karar yok. Yeni bir analiz başlatın!';

  @override
  String get homeUpgradePlan => 'Planı Yükselt';

  @override
  String get homeOpenSettings => 'Ayarları Aç';

  @override
  String get newDecisionTitle => 'Yeni Karar';

  @override
  String get newDecisionLabel => 'Karar Başlığı';

  @override
  String get newDecisionHint => 'Örn: Yatırım Portföyü Stratejisi';

  @override
  String get newDecisionDescriptionLabel => 'Kararınızı Tanımlayın';

  @override
  String get newDecisionDescriptionHint =>
      'Teknoloji hisseleri vs tahviller arasında yatırım yapmaya karar vermem gerekiyor...';

  @override
  String get newDecisionCategoryLabel => 'Karar Kategorisi';

  @override
  String get newDecisionCategoryHint => 'Kararınıza en uygun kategoriyi seçin';

  @override
  String get newDecisionModelLabel => 'AI Modeli';

  @override
  String get newDecisionAnalyze => 'Kararı Analiz Et';

  @override
  String get analysisTitle => 'Karar Analizi';

  @override
  String get analysisAnalyzing => 'Kararınız analiz ediliyor...';

  @override
  String get analysisPleaseWait => 'Bu bir dakika sürebilir';

  @override
  String get analysisInsufficientCredits => 'Yetersiz Kredi';

  @override
  String get analysisFailed => 'Analiz Başarısız';

  @override
  String get analysisCreditError =>
      'Krediniz kalmadı. Devam etmek için bir ödüllü reklam izleyin veya planınızı yükseltin.';

  @override
  String analysisNoApiKey(Object model) {
    return '$model için API anahtarı yapılandırılmamış. Anahtarınızı eklemek için Ayarlar\'a gidin.';
  }

  @override
  String get analysisRetry => 'Tekrar Dene';

  @override
  String get analysisUpgrade => 'Planı Yükselt';

  @override
  String get analysisRecommendation => 'Tavsiye';

  @override
  String get analysisBestChoice => 'En İyi Seçim';

  @override
  String get analysisConfidence => 'Güven';

  @override
  String get analysisHighlyConfident => 'Yüksek Güven';

  @override
  String get analysisModeratelyConfident => 'Orta Güven';

  @override
  String get analysisLowConfidence => 'Düşük Güven';

  @override
  String get analysisPros => 'Artılar';

  @override
  String get analysisCons => 'Eksiler';

  @override
  String get analysisRisks => 'Dikkate Alınması Gereken Riskler';

  @override
  String get analysisReasoning => 'Analiz Gerekçesi';

  @override
  String get analysisCopy => 'Kopyala';

  @override
  String get analysisShare => 'Paylaş';

  @override
  String get analysisExportPdf => 'PDF Dışa Aktar';

  @override
  String get analysisExporting => 'Dışa aktarılıyor...';

  @override
  String get analysisCopied => 'Analiz panoya kopyalandı';

  @override
  String get analysisShareSoon => 'Paylaşım özelliği yakında gelecek';

  @override
  String analysisPdfSaved(Object fileName) {
    return 'PDF $fileName olarak kaydedildi';
  }

  @override
  String get analysisPdfFailed =>
      'PDF kaydedilemedi. Farklı bir tarayıcı deneyin.';

  @override
  String analysisPdfExportFailed(Object error) {
    return 'PDF dışa aktarma başarısız: $error';
  }

  @override
  String get analysisFooter => 'Analiz referans amaçlıdır';

  @override
  String analysisAnalyzedWith(Object model) {
    return '$model ile analiz edildi';
  }

  @override
  String get analysisJustNow => 'Az önce';

  @override
  String get historyTitle => 'Karar Geçmişi';

  @override
  String get historySearch => 'Kararları ara...';

  @override
  String get historyNoDecisions => 'Henüz karar yok';

  @override
  String get historyNoDecisionsSubtitle =>
      'Analiz edilen kararlarınız burada görünecek.\nİlk kararınızı analiz ederek başlayın!';

  @override
  String get historyDeleteTitle => 'Kararı Sil';

  @override
  String get historyDeleteMessage =>
      'Bu kararı silmek istediğinize emin misiniz? Bu işlem geri alınamaz.';

  @override
  String get historyCancel => 'İptal';

  @override
  String get historyDelete => 'Sil';

  @override
  String get historyAll => 'Tümü';

  @override
  String get historyOldestFirst => 'Önce en eskiler';

  @override
  String get historyNewestFirst => 'Önce en yeniler';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsAiModel => 'AI Modeli';

  @override
  String get settingsDefaultModel => 'Varsayılan AI Modeli';

  @override
  String get settingsDefaultModelHint =>
      'Yeni karar oluştururken önceden seçili model';

  @override
  String get settingsApiKeys => 'API Anahtarları';

  @override
  String get settingsApiKeysHint =>
      'Her sağlayıcı için API anahtarlarınızı girin. Anahtarlar cihazınızda güvenle saklanır.';

  @override
  String settingsApiKeyHint(Object provider) {
    return '$provider API anahtarınızı girin';
  }

  @override
  String get settingsSave => 'Kaydet';

  @override
  String get settingsDelete => 'Sil';

  @override
  String settingsKeySaved(Object provider) {
    return '$provider anahtarı kaydedildi';
  }

  @override
  String settingsKeyDeleted(Object provider) {
    return '$provider anahtarı silindi';
  }

  @override
  String get settingsDeleteKeyTitle => 'API Anahtarını Sil';

  @override
  String settingsDeleteKeyMessage(Object provider) {
    return '$provider API anahtarı silinsin mi?';
  }

  @override
  String get settingsAppearance => 'Görünüm';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsLight => 'Açık';

  @override
  String get settingsDark => 'Koyu';

  @override
  String get settingsSystem => 'Sistem';

  @override
  String get settingsAbout => 'Hakkında';

  @override
  String settingsVersion(Object version) {
    return 'Sürüm $version';
  }

  @override
  String get settingsPrivacy =>
      'API anahtarlarınız, şifrelenmiş depolama kullanılarak cihazınızda güvenle saklanır. Hiçbir veri toplanmaz veya üçüncü taraflara iletilmez. Tüm AI analiz istekleri doğrudan seçilen sağlayıcıya gönderilir.';

  @override
  String get upgradeTitle => 'Planı Yükselt';

  @override
  String get upgradeChoosePlan => 'Planınızı Seçin';

  @override
  String get upgradeSubtitle =>
      'Daha fazla analiz ve premium özelliklerin kilidini açın';

  @override
  String get upgradeCurrentPlan => 'Mevcut Plan';

  @override
  String get upgradeSubscribe => 'Abone Ol';

  @override
  String get upgradeDowngrade => 'Düşür';

  @override
  String get upgradeRestore => 'Satın Alımları Geri Yükle';

  @override
  String get upgradeBestValue => 'EN İYİ DEĞER';

  @override
  String get freeTierName => 'Ücretsiz';

  @override
  String get freeTierFeature1 => '10 ücretsiz analiz';

  @override
  String get freeTierFeature2 => 'Reklam destekli';

  @override
  String get freeTierFeature3 => 'Temel AI analizi';

  @override
  String get freeTierLimit1 => 'PDF dışa aktarma yok';

  @override
  String get freeTierLimit2 => 'Öncelikli AI yok';

  @override
  String get premiumTierName => 'Premium';

  @override
  String get premiumTierPrice => '₺299.99/ay';

  @override
  String get premiumTierFeature1 => 'Ayda 300 analiz';

  @override
  String get premiumTierFeature2 => 'PDF dışa aktarma';

  @override
  String get premiumTierFeature3 => 'Reklam yok';

  @override
  String get premiumTierFeature4 => 'Standart AI modelleri';

  @override
  String get proTierName => 'Pro';

  @override
  String get proTierPrice => '₺599.99/ay';

  @override
  String get proTierFeature1 => 'Sınırsız analiz';

  @override
  String get proTierFeature2 => 'Sınırsız PDF dışa aktarma';

  @override
  String get proTierFeature3 => 'Öncelikli AI işleme';

  @override
  String get proTierFeature4 => 'Gelecekteki premium modeller';

  @override
  String get notificationDailyReminderTitle => 'Günlük Karar Kontrolü';

  @override
  String get notificationDailyReminderBody =>
      'Bugün önemli kararınızı düşündünüz mü? DecisionAI\'nin analiz etmenize yardımcı olmasına izin verin!';

  @override
  String get notificationDecisionReminderTitle => 'Karar Hatırlatıcı';

  @override
  String notificationDecisionReminderBody(Object title) {
    return '\"$title\" karar analizinizi gözden geçirmeyi unutmayın';
  }

  @override
  String get notificationChannelDaily => 'Günlük Hatırlatıcılar';

  @override
  String get notificationChannelDecision => 'Karar Hatırlatıcıları';

  @override
  String get creditTrackerCredits => 'kr';

  @override
  String get creditTrackerMonthly => 'ay';

  @override
  String get creditTrackerFree => 'Ücretsiz';

  @override
  String get creditTrackerPremium => 'Premium';

  @override
  String get creditTrackerPro => 'Pro';

  @override
  String get decisionTypePersonal => 'Kişisel';

  @override
  String get decisionTypeCareer => 'Kariyer';

  @override
  String get decisionTypeBusiness => 'İş';

  @override
  String get decisionTypeFinance => 'Finans';

  @override
  String get decisionTypeHealth => 'Sağlık';

  @override
  String get decisionTypeEducation => 'Eğitim';

  @override
  String get decisionTypeTravel => 'Seyahat';

  @override
  String get decisionTypeRelationship => 'İlişki';

  @override
  String get decisionTypeCustom => 'Özel';
}
