part of 'update_shipments_warehouse_arrival_cubit.dart';

sealed class UpdateShipmentsWarehouseArrivalState extends Equatable {
  const UpdateShipmentsWarehouseArrivalState();

  @override
  List<Object> get props => [];
}

final class UpdateShipmentsWarehouseArrivalInitial
    extends UpdateShipmentsWarehouseArrivalState {}

final class UpdateShipmentsWarehouseArrivalFailure
    extends UpdateShipmentsWarehouseArrivalState {
  final String message;

  const UpdateShipmentsWarehouseArrivalFailure(this.message);
}

final class UpdateShipmentsWarehouseArrivalLoading
    extends UpdateShipmentsWarehouseArrivalState {}

final class UpdateShipmentsWarehouseArrivalSuccess
    extends UpdateShipmentsWarehouseArrivalState {
  final UpdateShipmentsWarehouseArrivalEntity entity;

  const UpdateShipmentsWarehouseArrivalSuccess(this.entity);
}
