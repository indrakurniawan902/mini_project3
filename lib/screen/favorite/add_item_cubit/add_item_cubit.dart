import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:indie_commerce/models/cart_model.dart';
import 'package:indie_commerce/services/user_service.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(AddItemInitial());

  void addToFavorite(int productId,String uid)async{
    emit(AddItemLoading());
    try {
      final response = await UserService.instance.addToFavorite(productId, uid);
      emit(AddItemSuccess(response));
    } catch (e) {
      emit(AddItemError(e.toString()));
    }
  }

  void removeFavorite(int productId,String uid)async{
      emit(AddItemLoading());
    try {
      final response = await UserService.instance.removeFavorite(productId, uid);
      emit(AddItemSuccess(response));
    } catch (e) {
      emit(AddItemError(e.toString()));
    }
  }

    void addToCart(String uid,CartModel productId)async{
    emit(AddItemCartLoading());
    try {
      final response = await UserService.instance.addToCart(uid,productId);
      emit(AddItemCartSuccess(response));
    } catch (e) {
      emit(AddItemCartError(e.toString()));
    }
  }

  void removeCart(String uid,CartModel productData)async{
      emit(AddItemCartLoading());
    try {
      final response = await UserService.instance.removeFromCart(uid, productData);
      emit(AddItemCartSuccess(response));
    } catch (e) {
      emit(AddItemCartError(e.toString()));
    }
  }
}
