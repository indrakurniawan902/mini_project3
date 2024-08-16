import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:indie_commerce/models/cart_model.dart';
import 'package:indie_commerce/services/cart_service.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> getCartItems(String uid) async {
    emit(CartLoading());
    try {
      final cartItems = await CartService.instance.getCartItemsByUserId(uid);
      emit(CartLoaded(cartItems));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
