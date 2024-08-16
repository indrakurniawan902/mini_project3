import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:indie_commerce/models/product_model.dart';
import 'package:indie_commerce/services/product_service.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  void favoriteProduct(String uid) async {
    emit(FavoriteLoading());
    try {
      final response =
          await ProductService.instance.getFavorites(uid);
      emit(FavoriteSuccess(response));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }
}
