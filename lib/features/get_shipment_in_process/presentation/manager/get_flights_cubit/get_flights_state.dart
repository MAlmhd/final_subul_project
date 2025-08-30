part of 'get_flights_cubit.dart';

sealed class GetFlightsState extends Equatable {
  const GetFlightsState();

  @override
  List<Object> get props => [];
}

final class GetFlightsInitial extends GetFlightsState {}

final class GetFlightsLoading extends GetFlightsState {}

final class GetFlightsFailure extends GetFlightsState {
  final String message;

  const GetFlightsFailure(this.message);
}

final class GetFlightsSuccess extends GetFlightsState {
  final List<FlightEntity> flights;

  const GetFlightsSuccess(this.flights);
}
