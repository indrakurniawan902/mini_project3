import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indie_commerce/models/product_model.dart';
import 'package:indie_commerce/services/product_service.dart';

part 'detail_product_state.dart';

class DetailProductCubit extends Cubit<DetailProductState> {
  DetailProductCubit() : super(DetailProductInitial());

  Future<void> getProductById(int productId) async {
    emit(DetailProductLoading());
    try {
      final ProductModel product =
          await ProductService.instance.getProductById(productId);
      emit(DetailProductSuccess(product));
    } catch (e) {
      emit(
        DetailProductError(e.toString()),
      );
    }
  }
}
