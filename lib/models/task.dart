class Task {
  final String id;
  final int userId;
  final String name;
  final String description;
  final DateTime dateOfDelivery;
  final DateTime dateOfConclusion;
  final bool isConcluded;

  const Task({
    this.id,
    this.userId,
    this.name,
    this.description = '',
    this.dateOfDelivery,
    this.dateOfConclusion,
    this.isConcluded = false,
  });

  Task copyWith({
    String id,
    int userId,
    String name,
    String description,
    DateTime dateOfDelivery,
    DateTime dateOfConclusion,
    bool isConcluded,
  }) {
    return Task(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      dateOfDelivery: dateOfDelivery ?? this.dateOfDelivery,
      dateOfConclusion: dateOfConclusion ?? this.dateOfConclusion,
      isConcluded: isConcluded ?? this.isConcluded,
    );
  }
}
