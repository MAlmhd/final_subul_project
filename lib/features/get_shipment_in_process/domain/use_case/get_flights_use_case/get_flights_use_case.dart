import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/flight_entity/flight_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_flights_repo/get_flights_repo.dart';

class GetFlightsUseCase extends UseCase<List<FlightEntity>, NoParam> {
  final GetFlightsRepo getFlightsRepo;

  GetFlightsUseCase(this.getFlightsRepo);
  @override
  Future<Either<Failure, List<FlightEntity>>> call([NoParam? params]) async {
    return await getFlightsRepo.getFlights();
  }
}
