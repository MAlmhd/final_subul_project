part of 'create_parcel_cubit.dart';

sealed class CreateParcelState extends Equatable {
  const CreateParcelState();

  @override
  List<Object> get props => [];
}

final class CreateParcelInitial extends CreateParcelState {}

final class CreateParcelFailure extends CreateParcelState {
  final String message;

  const CreateParcelFailure(this.message);
}

final class CreateParcelLoading extends CreateParcelState {}

final class CreateParcelSuccess extends CreateParcelState {
  final CreateParcelEntity createParcelEntity;

  const CreateParcelSuccess(this.createParcelEntity);
}
