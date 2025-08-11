part of 'get_parcel_items_cubit.dart';

sealed class GetParcelItemsState extends Equatable {
  const GetParcelItemsState();

  @override
  List<Object> get props => [];
}

final class GetParcelItemsInitial extends GetParcelItemsState {}

final class GetParcelItemsFailure extends GetParcelItemsState {
  final String message;

  const GetParcelItemsFailure(this.message);
}

final class GetParcelItemsLoading extends GetParcelItemsState {}

final class GetParcelItemsSuccess extends GetParcelItemsState {
  final List<GetParcelItemsEntity> items;

  const GetParcelItemsSuccess(this.items);
}
