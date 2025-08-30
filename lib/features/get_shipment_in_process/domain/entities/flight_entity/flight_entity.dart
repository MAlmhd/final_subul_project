// flight_entity.dart
import 'airport_entity.dart';

class FlightEntity {
  final int id;
  final String flightNumber;
  final int departureAirportId;
  final int arrivalAirportId;

  final DateTime departureTime;
  final DateTime arrivalTime;

  final DateTime createdAt;
  final DateTime updatedAt;

  /// كائنات المطار الاختيارية القادمة ضمن الـ JSON
  final AirportEntity? departureAirport;
  final AirportEntity? arrivalAirport;

  const FlightEntity({
    required this.id,
    required this.flightNumber,
    required this.departureAirportId,
    required this.arrivalAirportId,
    required this.departureTime,
    required this.arrivalTime,
    required this.createdAt,
    required this.updatedAt,
    this.departureAirport,
    this.arrivalAirport,
  });
}
