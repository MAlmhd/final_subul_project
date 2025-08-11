part of 'update_shipment_for_delivery_cubit.dart';

sealed class UpdateShipmentForDeliveryState extends Equatable {
  const UpdateShipmentForDeliveryState();

  @override
  List<Object> get props => [];
}

final class UpdateShipmentForDeliveryInitial
    extends UpdateShipmentForDeliveryState {}

final class UpdateShipmentForDeliveryFailure
    extends UpdateShipmentForDeliveryState {
  final String message;

  const UpdateShipmentForDeliveryFailure(this.message);
}

final class UpdateShipmentForDeliveryLoading
    extends UpdateShipmentForDeliveryState {}

final class UpdateShipmentForDeliverySuccess
    extends UpdateShipmentForDeliveryState {
  final UpdateShipmentForDeliveryEntity entity;

  const UpdateShipmentForDeliverySuccess(this.entity);
}
