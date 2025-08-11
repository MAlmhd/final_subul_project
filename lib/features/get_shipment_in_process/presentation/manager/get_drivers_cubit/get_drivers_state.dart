part of 'get_drivers_cubit.dart';

sealed class GetDriversState extends Equatable {
  const GetDriversState();

  @override
  List<Object> get props => [];
}

final class GetDriversInitial extends GetDriversState {}

final class GetDriversFailure extends GetDriversState {
  final String message;

  const GetDriversFailure(this.message);
}

final class GetDriversLoading extends GetDriversState {}

final class GetDriversSuccess extends GetDriversState {
  final List<DriverEntity> drivers;

  const GetDriversSuccess(this.drivers);
}
