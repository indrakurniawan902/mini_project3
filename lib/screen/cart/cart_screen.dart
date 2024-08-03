import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indie_commerce/models/product_model.dart';
import 'package:indie_commerce/screen/cart/cubits/cart_cubit/cart_cubit.dart';
import 'package:indie_commerce/screen/cart/cubits/price_total_cubit/price_total_cubit.dart';
import 'package:indie_commerce/screen/cart/widgets/cart_item_card_widget.dart';
import 'package:indie_commerce/screen/home/cubit/product_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<CartCubit>().getCartItems();
    context.read<PriceTotalCubit>().countPriceTotal();
    super.initState();
  }

  // double totalPrice = 0.0;

  // ValueNotifier<double> priceTotal = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Cart",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (productContext, productState) {
          productState as ProductSuccess;
          final products = productState.allProducts;
          return BlocBuilder<CartCubit, CartState>(
            builder: (cartContext, cartState) {
              if (cartState is CartLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (cartState is CartLoaded) {
                final cartItems = cartState.cartItems;
                List<ProductModel> cartProducts = [];
                for (var product in products) {
                  for (var cartItem in cartItems) {
                    if (product.id == cartItem.productId) {
                      cartProducts.add(product);
                    }
                  }
                }
                log(cartProducts.toString());
                return Padding(
                  padding: const EdgeInsets.only(top: 36, left: 16, right: 16),
                  child: ListView.builder(
                    itemCount: cartProducts.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      final item = cartProducts[index];
                      return CartItemCardWidget(
                          product: item, quantity: cartItem.quantity!);
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text("Terjadi Kesalahan"),
                );
              }
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 24),
          margin: const EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 0),
          alignment: Alignment.center,
          width: double.infinity,
          height: 240,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: BlocBuilder<PriceTotalCubit, PriceTotalState>(
            builder: (context, state) {
              state as CountPriceTotal;
              double priceTotal = state.priceTotal;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "\$$priceTotal",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping Fee",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "\$10.00",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 36,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Subtotal",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "\$${priceTotal + 10}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 12, bottom: 12, left: 32, right: 32),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color(0xff1E1F2E),
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
