part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final List<ProductModel> allProducts;
  const ProductSuccess(this.allProducts);

  @override
  List<Object> get props => [allProducts];
}

final class ProductError extends ProductState {
  final String error;
  const ProductError(this.error);

  @override
  List<Object> get props => [error];
}
