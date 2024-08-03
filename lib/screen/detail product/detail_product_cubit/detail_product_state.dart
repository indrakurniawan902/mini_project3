part of 'detail_product_cubit.dart';

sealed class DetailProductState extends Equatable {
  const DetailProductState();

  @override
  List<Object> get props => [];
}

final class DetailProductInitial extends DetailProductState {}

final class DetailProductLoading extends DetailProductState {}

final class DetailProductSuccess extends DetailProductState {
  const DetailProductSuccess(this.product);
  final ProductModel product;

  @override
  List<Object> get props => [product];
}

final class DetailProductError extends DetailProductState {
  const DetailProductError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
