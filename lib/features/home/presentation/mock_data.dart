enum DecisionStatus { completed, inProgress, pending }

class Decision {
  final String title;
  final String description;
  final DateTime date;
  final DecisionStatus status;

  const Decision({
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });
}

final List<Decision> mockDecisions = [
  Decision(
    title: 'Investment Portfolio',
    description: 'Tech stocks vs Bonds allocation',
    date: DateTime(2026, 7, 12),
    status: DecisionStatus.completed,
  ),
  Decision(
    title: 'Marketing Strategy',
    description: 'Q3 social media campaign budget',
    date: DateTime(2026, 7, 10),
    status: DecisionStatus.inProgress,
  ),
  Decision(
    title: 'Vendor Selection',
    description: 'Cloud service provider evaluation',
    date: DateTime(2026, 7, 7),
    status: DecisionStatus.pending,
  ),
];
