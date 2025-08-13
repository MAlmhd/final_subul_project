part of 'get_suppliers_cubit.dart';

sealed class GetSuppliersState extends Equatable {
  const GetSuppliersState();

  @override
  List<Object> get props => [];
}

final class GetSuppliersInitial extends GetSuppliersState {}

final class GetSuppliersFailures extends GetSuppliersState {
  final String message;

  const GetSuppliersFailures(this.message);
}

final class GetSuppliersLoading extends GetSuppliersState {}

final class GetSuppliersSuccess extends GetSuppliersState {
  final List<SupplierEntity> suppliers;

  const GetSuppliersSuccess(this.suppliers);
}
