import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:indie_commerce/models/product_model.dart';
import 'package:indie_commerce/services/product_service.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  void getAllProduct() async {
    emit(ProductLoading());
    try {
      final data = await ProductService.instance.getAllProduct();
      emit(ProductSuccess(data.cast<ProductModel>()));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void getCategoriesProduct(String category) async {
    emit(ProductLoading());
    try {
      final data = await ProductService.instance.getCategoriesProduct(category);
      emit(ProductSuccess(data));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
