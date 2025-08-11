part of 'update_shipment_destenation_country_cubit.dart';

sealed class UpdateShipmentDestenationCountryState extends Equatable {
  const UpdateShipmentDestenationCountryState();

  @override
  List<Object> get props => [];
}

final class UpdateShipmentDestenationCountryInitial
    extends UpdateShipmentDestenationCountryState {}

final class UpdateShipmentDestenationCountryFailure
    extends UpdateShipmentDestenationCountryState {
  final String message;

  const UpdateShipmentDestenationCountryFailure(this.message);
}

final class UpdateShipmentDestenationCountryLoading
    extends UpdateShipmentDestenationCountryState {}

final class UpdateShipmentDestenationCountrySuccess
    extends UpdateShipmentDestenationCountryState {
  final UpdateDestenationCountryEntity entity;

  const UpdateShipmentDestenationCountrySuccess(this.entity);
}
