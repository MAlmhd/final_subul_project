part of 'get_all_parcels_cubit.dart';

sealed class GetAllParcelsState extends Equatable {
  const GetAllParcelsState();

  @override
  List<Object> get props => [];
}

final class GetAllParcelsInitial extends GetAllParcelsState {}

final class GetAllParcelsFailure extends GetAllParcelsState {
  final String message;

  const GetAllParcelsFailure(this.message);
}

final class GetAllParcelsLoading extends GetAllParcelsState {}

final class GetAllParcelsSuccess extends GetAllParcelsState {
  final List<ParcelEntity> parcels;

  const GetAllParcelsSuccess(this.parcels);
}
