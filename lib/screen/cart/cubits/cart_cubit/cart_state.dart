part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<CartModel> cartItems;
  const CartLoaded(this.cartItems);

  @override
  List<Object> get props => [cartItems];
}

final class CartError extends CartState {
  final String error;
  const CartError(this.error);

  @override
  List<Object> get props => [error];
}
