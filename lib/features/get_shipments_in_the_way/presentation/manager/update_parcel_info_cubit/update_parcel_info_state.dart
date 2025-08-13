part of 'update_parcel_info_cubit.dart';

sealed class UpdateParcelInfoState extends Equatable {
  const UpdateParcelInfoState();

  @override
  List<Object> get props => [];
}

final class UpdateParcelInfoInitial extends UpdateParcelInfoState {}

final class UpdateParcelInfoFailure extends UpdateParcelInfoState {
  final String message;
  const UpdateParcelInfoFailure(this.message);
}

final class UpdateParcelInfoLoading extends UpdateParcelInfoState {}

final class UpdateParcelInfoSuccess extends UpdateParcelInfoState {
  final UpdateParcelInfoEntity entity;

  const UpdateParcelInfoSuccess(this.entity);
}
