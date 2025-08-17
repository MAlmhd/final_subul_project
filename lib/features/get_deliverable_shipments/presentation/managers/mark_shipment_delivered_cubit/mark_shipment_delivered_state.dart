part of 'mark_shipment_delivered_cubit.dart';

sealed class MarkShipmentDeliveredState extends Equatable {
  const MarkShipmentDeliveredState();

  @override
  List<Object> get props => [];
}

final class MarkShipmentDeliveredInitial extends MarkShipmentDeliveredState {}

final class MarkShipmentDeliveredFailure extends MarkShipmentDeliveredState {
  final String message;
  const MarkShipmentDeliveredFailure(this.message);
}

final class MarkShipmentDeliveredLoading extends MarkShipmentDeliveredState {}

final class MarkShipmentDeliveredSuccess extends MarkShipmentDeliveredState {
  final MarkShipmentDeliveredEntity markShipmentDeliveredEntity;

  const MarkShipmentDeliveredSuccess(this.markShipmentDeliveredEntity);
}
