import '../../../l10n/app_localizations.dart';

enum DecisionType {
  personal,
  career,
  business,
  finance,
  health,
  education,
  travel,
  relationship,
  custom;

  String get displayName {
    switch (this) {
      case DecisionType.personal:
        return 'Personal';
      case DecisionType.career:
        return 'Career';
      case DecisionType.business:
        return 'Business';
      case DecisionType.finance:
        return 'Finance';
      case DecisionType.health:
        return 'Health';
      case DecisionType.education:
        return 'Education';
      case DecisionType.travel:
        return 'Travel';
      case DecisionType.relationship:
        return 'Relationship';
      case DecisionType.custom:
        return 'Custom';
    }
  }

  String localizedDisplayName(AppLocalizations l10n) {
    switch (this) {
      case DecisionType.personal:
        return l10n.decisionTypePersonal;
      case DecisionType.career:
        return l10n.decisionTypeCareer;
      case DecisionType.business:
        return l10n.decisionTypeBusiness;
      case DecisionType.finance:
        return l10n.decisionTypeFinance;
      case DecisionType.health:
        return l10n.decisionTypeHealth;
      case DecisionType.education:
        return l10n.decisionTypeEducation;
      case DecisionType.travel:
        return l10n.decisionTypeTravel;
      case DecisionType.relationship:
        return l10n.decisionTypeRelationship;
      case DecisionType.custom:
        return l10n.decisionTypeCustom;
    }
  }

  String get promptLabel {
    switch (this) {
      case DecisionType.personal:
        return 'Personal Development';
      case DecisionType.career:
        return 'Career & Professional';
      case DecisionType.business:
        return 'Business & Strategy';
      case DecisionType.finance:
        return 'Financial Planning';
      case DecisionType.health:
        return 'Health & Wellness';
      case DecisionType.education:
        return 'Education & Learning';
      case DecisionType.travel:
        return 'Travel & Relocation';
      case DecisionType.relationship:
        return 'Relationships';
      case DecisionType.custom:
        return 'General Decision';
    }
  }
}
