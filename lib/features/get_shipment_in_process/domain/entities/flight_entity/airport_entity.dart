// airport_entity.dart
class AirportEntity {
  final int id;
  final String code;
  final String name;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AirportEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });
}
