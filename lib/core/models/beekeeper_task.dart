enum BeekeeperTaskStatus { open, done }

enum BeekeeperTaskPriority { low, normal, high }

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
    required this.description,
    required this.hiveId,
    required this.category,
    required this.dueDate,
    required this.dueTime,
    required this.status,
    required this.priority,
    required this.createdAt,
    required this.completedAt,
  });

  final String id;
  final String title;
  final String description;
  final String hiveId;
  final BeekeeperTaskCategory category;
  final DateTime dueDate;
  final DateTime? dueTime;
  final BeekeeperTaskStatus status;
  final BeekeeperTaskPriority priority;
  final DateTime createdAt;
  final DateTime? completedAt;

  bool get isOpen => status == BeekeeperTaskStatus.open;

  BeekeeperTask copyWith({
    String? id,
    String? title,
    String? description,
    String? hiveId,
    BeekeeperTaskCategory? category,
    DateTime? dueDate,
    DateTime? dueTime,
    BeekeeperTaskStatus? status,
    BeekeeperTaskPriority? priority,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return BeekeeperTask(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      hiveId: hiveId ?? this.hiveId,
      category: category ?? this.category,
      dueDate: dueDate ?? this.dueDate,
      dueTime: dueTime ?? this.dueTime,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

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

  String get priorityLabel {
    return switch (priority) {
      BeekeeperTaskPriority.low => 'Niedrig',
      BeekeeperTaskPriority.normal => 'Normal',
      BeekeeperTaskPriority.high => 'Hoch',
    };
  }
}
