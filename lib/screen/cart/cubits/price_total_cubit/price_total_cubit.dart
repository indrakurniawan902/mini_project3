import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:indie_commerce/services/cart_service.dart';
import 'package:indie_commerce/services/product_service.dart';

part 'price_total_state.dart';

class PriceTotalCubit extends Cubit<PriceTotalState> {
  PriceTotalCubit() : super(const CountPriceTotal(0));

  void countPriceTotal() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final products = await ProductService.instance.getAllProduct();
    final carts = await CartService.instance.getCartItemsByUserId(uid);

    double priceTotal = 0;
    for (var cart in carts) {
      for (var product in products) {
        if (product.id == cart.id) {
          priceTotal += product.price! * cart.quantity!;
        }
      }
    }
    log(priceTotal.toString());
    emit(CountPriceTotal(priceTotal));
  }
}
