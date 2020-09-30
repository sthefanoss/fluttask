class Task {
  final int id;
  final int userId;
  final String name;
  final String description;
  final DateTime creationDate;
  final DateTime conclusionDate;
  final bool isConcluded;

  const Task({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.creationDate,
    this.conclusionDate,
    this.isConcluded,
  });
}
