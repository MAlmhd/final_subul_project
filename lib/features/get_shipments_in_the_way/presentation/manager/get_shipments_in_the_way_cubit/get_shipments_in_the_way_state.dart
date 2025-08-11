part of 'get_shipments_in_the_way_cubit.dart';

sealed class GetShipmentsInTheWayState extends Equatable {
  const GetShipmentsInTheWayState();

  @override
  List<Object> get props => [];
}

final class GetShipmentsInTheWayInitial extends GetShipmentsInTheWayState {}

final class GetShipmentsInTheWayLoading extends GetShipmentsInTheWayState {}

final class GetShipmentsInTheWayFailure extends GetShipmentsInTheWayState {
  final String message;

  const GetShipmentsInTheWayFailure(this.message);
}

final class GetShipmentsInTheWaySuccess extends GetShipmentsInTheWayState {
  final List<ShipmentInTheWayEntity> shipments;

  const GetShipmentsInTheWaySuccess(this.shipments);
}
