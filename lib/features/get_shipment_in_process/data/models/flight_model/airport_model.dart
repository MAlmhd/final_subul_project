// airport_model.dart
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/flight_entity/airport_entity.dart';



class AirportModel extends AirportEntity {
  AirportModel({
    required super.id,
    required super.code,
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AirportModel.fromJson(Map<String, dynamic> json) {
    DateTime _parseIso(String v) => DateTime.parse(v);
    double _toDouble(dynamic v) =>
        (v is num) ? v.toDouble() : double.parse(v.toString());

    return AirportModel(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      latitude: _toDouble(json['latitude']),
      longitude: _toDouble(json['longitude']),
      createdAt: _parseIso(json['created_at'] as String),
      updatedAt: _parseIso(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
