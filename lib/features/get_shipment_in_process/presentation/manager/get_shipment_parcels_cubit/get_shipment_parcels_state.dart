part of 'get_shipment_parcels_cubit.dart';

sealed class GetShipmentParcelsState extends Equatable {
  const GetShipmentParcelsState();

  @override
  List<Object> get props => [];
}

final class GetShipmentParcelsInitial extends GetShipmentParcelsState {}

final class GetShipmentParcelsFailure extends GetShipmentParcelsState {
  final String message;

  const GetShipmentParcelsFailure(this.message);
}

final class GetShipmentParcelsLoading extends GetShipmentParcelsState {}

final class GetShipmentParcelsSuccess extends GetShipmentParcelsState {
  final List<SpecificParcelsOfShipmentEntity> parcels;

  const GetShipmentParcelsSuccess(this.parcels);
}
