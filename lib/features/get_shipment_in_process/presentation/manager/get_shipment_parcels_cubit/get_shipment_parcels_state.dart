
import 'package:equatable/equatable.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/specific_parcels_of_shipment_entity/specific_parcels_of_shipment_entity.dart';

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
  final SpecificParcelsOfShipmentEntity parcels;

  const GetShipmentParcelsSuccess(this.parcels);
}
