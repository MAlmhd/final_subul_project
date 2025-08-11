part of 'get_shipment_details_cubit.dart';

sealed class GetShipmentDetailsState extends Equatable {
  const GetShipmentDetailsState();

  @override
  List<Object> get props => [];
}

final class GetShipmentDetailsInitial extends GetShipmentDetailsState {}

final class GetShipmentDetailsFailure extends GetShipmentDetailsState {
  final String message;

  const GetShipmentDetailsFailure(this.message);
}

final class GetShipmentDetailsLoading extends GetShipmentDetailsState {}

final class GetShipmentDetailsSuccess extends GetShipmentDetailsState {
  final GetShipmentDetailsEntity entity;

  const GetShipmentDetailsSuccess(this.entity);
}
