part of 'get_shipment_in_proccess_cubit.dart';

sealed class GetShipmentInProccessState extends Equatable {
  const GetShipmentInProccessState();

  @override
  List<Object> get props => [];
}

final class GetShipmentInProccessInitial extends GetShipmentInProccessState {}

final class GetShipmentInProccessFailure extends GetShipmentInProccessState {
  final String message;

  const GetShipmentInProccessFailure(this.message);
}

final class GetShipmentInProccessLoading extends GetShipmentInProccessState {}

final class GetShipmentInProccessSuccess extends GetShipmentInProccessState {
  final List<ShipmentInProcessEntity> shipments;

  const GetShipmentInProccessSuccess(this.shipments);
}
