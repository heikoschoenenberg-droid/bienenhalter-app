class BeeStand {
  const BeeStand({
    required this.id,
    required this.name,
    required this.location,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String location;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
}
