part of 'get_deliverable_shipments_cubit.dart';

sealed class GetDeliverableShipmentsState extends Equatable {
  const GetDeliverableShipmentsState();

  @override
  List<Object> get props => [];
}

final class GetDeliverableShipmentsInitial
    extends GetDeliverableShipmentsState {}

final class GetDeliverableShipmentsFailure
    extends GetDeliverableShipmentsState {
  final String message;
  const GetDeliverableShipmentsFailure(this.message);
}

final class GetDeliverableShipmentsLoading
    extends GetDeliverableShipmentsState {}

final class GetDeliverableShipmentsSuccess
    extends GetDeliverableShipmentsState {
  final List<GetDeliverableShipmentsEntity> shipments;

  const GetDeliverableShipmentsSuccess(this.shipments);
}
