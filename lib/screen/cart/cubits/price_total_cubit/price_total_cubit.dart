import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:indie_commerce/services/cart_service.dart';
import 'package:indie_commerce/services/product_service.dart';

part 'price_total_state.dart';

class PriceTotalCubit extends Cubit<PriceTotalState> {
  PriceTotalCubit() : super(const CountPriceTotal(0));

  void countPriceTotal() async {
    final products = await ProductService.instance.getAllProduct();
    final carts = await CartService.instance.getCartItemsByUserId();

    double priceTotal = 0;
    for (var cart in carts) {
      for (var product in products) {
        if (product.id == cart.productId) {
          priceTotal += product.price! * cart.quantity!;
        }
      }
    }
    log(priceTotal.toString());
    emit(CountPriceTotal(priceTotal));
  }
}
