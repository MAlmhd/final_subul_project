part of 'get_invoice_details_cubit.dart';

sealed class GetInvoiceDetailsState extends Equatable {
  const GetInvoiceDetailsState();

  @override
  List<Object> get props => [];
}

final class GetInvoiceDetailsInitial extends GetInvoiceDetailsState {}

final class GetInvoiceDetailsFailure extends GetInvoiceDetailsState {
  final String message;

  const GetInvoiceDetailsFailure(this.message);
}

final class GetInvoiceDetailsLoading extends GetInvoiceDetailsState {}

final class GetInvoiceDetailsSuccess extends GetInvoiceDetailsState {
  final InvoiceDetailsResponseEntity entity;

  const GetInvoiceDetailsSuccess(this.entity);
}
