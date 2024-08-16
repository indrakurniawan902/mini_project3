part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class PaymentPostLoading extends PaymentState {}

final class PaymentPostSuccess extends PaymentState {
  final String message;
  const PaymentPostSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class PaymentPostError extends PaymentState {
  final String message;
  const PaymentPostError(this.message);

  @override
  List<Object> get props => [message];
}

final class PaymentGetLoading extends PaymentState {}

final class PaymentGetSuccess extends PaymentState {
  final List<StatusModel> data;
  const PaymentGetSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class PaymentGetError extends PaymentState {
  final String message;
  const PaymentGetError(this.message);

  @override
  List<Object> get props => [message];
}
