
import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/flight_entity/flight_entity.dart';

abstract class GetFlightsRepo {
  

  Future<Either<Failure,List<FlightEntity>>> getFlights();
}
