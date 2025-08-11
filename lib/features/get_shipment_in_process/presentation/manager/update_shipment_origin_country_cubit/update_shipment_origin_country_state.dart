part of 'update_shipment_origin_country_cubit.dart';

sealed class UpdateShipmentOriginCountryState extends Equatable {
  const UpdateShipmentOriginCountryState();

  @override
  List<Object> get props => [];
}

final class UpdateShipmentOriginCountryInitial
    extends UpdateShipmentOriginCountryState {}

final class UpdateShipmentOriginCountryLoading
    extends UpdateShipmentOriginCountryState {}

final class UpdateShipmentOriginCountryFailure
    extends UpdateShipmentOriginCountryState {
  final String message;

  const UpdateShipmentOriginCountryFailure(this.message);
}

final class UpdateShipmentOriginCountrySuccess
    extends UpdateShipmentOriginCountryState {
  final UpdateOriginCountryEntity entity;

  const UpdateShipmentOriginCountrySuccess(this.entity);
}
