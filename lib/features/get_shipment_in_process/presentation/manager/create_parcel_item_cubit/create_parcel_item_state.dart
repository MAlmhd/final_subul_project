part of 'create_parcel_item_cubit.dart';

sealed class CreateParcelItemState extends Equatable {
  const CreateParcelItemState();

  @override
  List<Object> get props => [];
}

final class CreateParcelItemInitial extends CreateParcelItemState {}

final class CreateParcelItemFailure extends CreateParcelItemState {
  final String message;

  const CreateParcelItemFailure(this.message);
}

final class CreateParcelItemLoading extends CreateParcelItemState {}

final class CreateParcelItemSuccess extends CreateParcelItemState {
  final CreateParcelItemEntity entity;

  const CreateParcelItemSuccess(this.entity);
}
