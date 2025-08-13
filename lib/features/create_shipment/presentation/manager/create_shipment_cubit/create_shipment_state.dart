part of 'create_shipment_cubit.dart';

sealed class CreateShipmentState extends Equatable {
  const CreateShipmentState();

  @override
  List<Object> get props => [];
}

final class CreateShipmentInitial extends CreateShipmentState {}

final class CreateShipmentFailure extends CreateShipmentState {
  final String message;

  const CreateShipmentFailure(this.message);
}

final class CreateShipmentLoading extends CreateShipmentState {}

final class CreateShipmentSuccess extends CreateShipmentState {
  final CreateShipmentEntity entity;

  const CreateShipmentSuccess(this.entity);
}
