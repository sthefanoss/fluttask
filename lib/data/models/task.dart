class Task {
  final String id;
  final String userEmail;
  final String name;
  final String description;
  final DateTime dateOfDelivery;
  final DateTime dateOfConclusion;
  final bool isConcluded;

  const Task({
    this.id,
    this.userEmail,
    this.name,
    this.description = '',
    this.dateOfDelivery,
    this.dateOfConclusion,
    this.isConcluded = false,
  });

  factory Task.fromMap(Map map) {
    return Task(
      id: map['id'],
      userEmail: map['userEmail'],
      name: map['name'],
      description: map['description'],
      isConcluded: map['isConcluded'] == 1,
      dateOfDelivery: DateTime.parse(map['dateOfDelivery']),
      dateOfConclusion: DateTime.tryParse(map['dateOfConclusion']) ?? null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userEmail': userEmail,
      'name': name,
      'description': description,
      'isConcluded': isConcluded ? 1 : 0,
      'dateOfDelivery': dateOfDelivery.toIso8601String(),
      'dateOfConclusion':
          dateOfConclusion != null ? dateOfConclusion.toIso8601String() : '',
    };
  }

  Task copyWith({
    String id,
    String userEmail,
    String name,
    String description,
    DateTime dateOfDelivery,
    DateTime dateOfConclusion,
    bool isConcluded,
  }) {
    return Task(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      name: name ?? this.name,
      description: description ?? this.description,
      dateOfDelivery: dateOfDelivery ?? this.dateOfDelivery,
      dateOfConclusion: dateOfConclusion ?? this.dateOfConclusion,
      isConcluded: isConcluded ?? this.isConcluded,
    );
  }
}
