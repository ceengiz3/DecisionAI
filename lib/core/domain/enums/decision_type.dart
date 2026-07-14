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
