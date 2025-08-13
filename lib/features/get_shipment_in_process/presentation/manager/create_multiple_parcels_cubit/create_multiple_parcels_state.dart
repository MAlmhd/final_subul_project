part of 'create_multiple_parcels_cubit.dart';

sealed class CreateMultipleParcelsState extends Equatable {
  const CreateMultipleParcelsState();

  @override
  List<Object> get props => [];
}

final class CreateMultipleParcelsInitial extends CreateMultipleParcelsState {}

final class CreateMultipleParcelsFailure extends CreateMultipleParcelsState {
  final String message;

  const CreateMultipleParcelsFailure(this.message);
}

final class CreateMultipleParcelsLoading extends CreateMultipleParcelsState {}

final class CreateMultipleParcelsSuccess extends CreateMultipleParcelsState {
  final CreateMultipleParcelsEntity entity;

  const CreateMultipleParcelsSuccess(this.entity);
}
