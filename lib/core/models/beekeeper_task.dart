enum BeekeeperTaskStatus { open, done }

enum BeekeeperTaskCategory {
  inspection,
  honeySuper,
  beeEscape,
  varroa,
  feeding,
  queen,
  other,
}

class BeekeeperTask {
  const BeekeeperTask({
    required this.id,
    required this.title,
    required this.hiveId,
    required this.category,
    required this.dueDate,
    required this.status,
  });

  final String id;
  final String title;
  final String hiveId;
  final BeekeeperTaskCategory category;
  final DateTime dueDate;
  final BeekeeperTaskStatus status;

  bool get isOpen => status == BeekeeperTaskStatus.open;

  String get categoryLabel {
    return switch (category) {
      BeekeeperTaskCategory.inspection => 'Kontrolle',
      BeekeeperTaskCategory.honeySuper => 'Honigraum',
      BeekeeperTaskCategory.beeEscape => 'Bienenflucht',
      BeekeeperTaskCategory.varroa => 'Varroa',
      BeekeeperTaskCategory.feeding => 'Fuetterung',
      BeekeeperTaskCategory.queen => 'Koenigin',
      BeekeeperTaskCategory.other => 'Sonstiges',
    };
  }

  String get warningLabel {
    return switch (category) {
      BeekeeperTaskCategory.inspection => 'Kontrolle faellig',
      BeekeeperTaskCategory.honeySuper => 'Honigraum pruefen',
      BeekeeperTaskCategory.beeEscape => 'Bienenflucht pruefen',
      BeekeeperTaskCategory.varroa => 'Varroa offen',
      BeekeeperTaskCategory.feeding => 'Fuetterung pruefen',
      BeekeeperTaskCategory.queen => 'Koenigin pruefen',
      BeekeeperTaskCategory.other => 'Aufgabe offen',
    };
  }
}
