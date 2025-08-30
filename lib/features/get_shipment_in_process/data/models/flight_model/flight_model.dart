// flight_model.dart
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/flight_entity/flight_entity.dart';


import 'airport_model.dart';

class FlightModel extends FlightEntity {
  FlightModel({
    required super.id,
    required super.flightNumber,
    required super.departureAirportId,
    required super.arrivalAirportId,
    required super.departureTime,
    required super.arrivalTime,
    required super.createdAt,
    required super.updatedAt,
    super.departureAirport,
    super.arrivalAirport,
  });

  /// يقبل كلا الصيغتين:
  /// "2025-08-29 08:00:00" أو "2025-08-29T08:00:00.000Z"
  static DateTime _parseDate(dynamic v) {
    if (v == null) return DateTime.fromMillisecondsSinceEpoch(0);
    final s = v.toString().trim();
    if (s.contains('T')) return DateTime.parse(s);
    // عدّلها لصيغة ISO سريعة
    return DateTime.parse(s.replaceFirst(' ', 'T'));
  }

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      id: json['id'] as int,
      flightNumber: json['flight_number'] as String,
      departureAirportId: json['departure_airport_id'] as int,
      arrivalAirportId: json['arrival_airport_id'] as int,
      departureTime: _parseDate(json['departure_time']),
      arrivalTime: _parseDate(json['arrival_time']),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      departureAirport: json['departure_airport'] == null
          ? null
          : AirportModel.fromJson(json['departure_airport']
              as Map<String, dynamic>), // يرث من AirportEntity
      arrivalAirport: json['arrival_airport'] == null
          ? null
          : AirportModel.fromJson(
              json['arrival_airport'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'flight_number': flightNumber,
        'departure_airport_id': departureAirportId,
        'arrival_airport_id': arrivalAirportId,
        // للحفاظ على تنسيق backend للوقت الأساسي (مسافة بدل T)
        'departure_time': departureTime.toIso8601String().replaceFirst('T', ' ').split('.').first,
        'arrival_time': arrivalTime.toIso8601String().replaceFirst('T', ' ').split('.').first,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        if (departureAirport != null)
          'departure_airport':
              (departureAirport as AirportModel).toJson(),
        if (arrivalAirport != null)
          'arrival_airport': (arrivalAirport as AirportModel).toJson(),
      };
}
