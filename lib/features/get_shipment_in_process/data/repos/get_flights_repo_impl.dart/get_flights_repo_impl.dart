import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/get_flights_remote_data_source/get_flights_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/flight_entity/flight_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_flights_repo/get_flights_repo.dart';

class GetFlightsRepoImpl implements GetFlightsRepo {
  final GetFlightsRemoteDataSource getFlightsRemoteDataSource;

  GetFlightsRepoImpl(this.getFlightsRemoteDataSource);
  @override
  Future<Either<Failure, List<FlightEntity>>> getFlights() async {
    try {
      var data = await getFlightsRemoteDataSource.getFlights();
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
