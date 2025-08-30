import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/models/flight_model/flight_model.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/flight_entity/flight_entity.dart';

abstract class GetFlightsRemoteDataSource {
  Future<List<FlightEntity>> getFlights();
}


class GetFlightsRemoteDataSourceImpl implements GetFlightsRemoteDataSource{
  final ApiService _apiService;

  GetFlightsRemoteDataSourceImpl(this._apiService);
  @override
  Future<List<FlightEntity>> getFlights()async {
    final token = await sl.get<AuthLocalDataSource>().getToken();
    var data = await _apiService.get(
      endPoint: 'flights',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (data['data'] == null) {
      return [];
    }
    List<FlightEntity> flights = [];
    for (var element in data['data']) {
      flights.add(FlightModel.fromJson(element));
    }

    return flights;
  }
}
