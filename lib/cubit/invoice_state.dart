part of 'invoice_cubit.dart';

abstract class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object> get props => [identityHashCode(this)];
}

final class InvoiceInitial extends InvoiceState {}

final class InvoiceDatabaseOpenedSuccesfully extends InvoiceState {}

final class InvoiceDatabaseOpenedFailed extends InvoiceState {
  final String? message;

  const InvoiceDatabaseOpenedFailed({required this.message});
}

final class InvoiceLoadingState extends InvoiceState {}

final class InvoiceGetInvoicesSuccessState extends InvoiceState {}

final class InvoiceGetInvoicesErrorState extends InvoiceState {
  final String? message;

  const InvoiceGetInvoicesErrorState({required this.message});
}

final class InvoiceOperationSuccessState extends InvoiceState {}

final class InvoiceOperationErrorState extends InvoiceState {
  final String? message;

  const InvoiceOperationErrorState({required this.message});
}
//! UI
final class ChangeNameState extends InvoiceState {}
final class ChangePriceState extends InvoiceState {}
final class ChangeQuantityState extends InvoiceState {}
final class ChangeTotalState extends InvoiceState {}
final class ChangeExpiryDateState extends InvoiceState {}

final class ChangeUnitState extends InvoiceState {}