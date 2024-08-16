import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:indie_commerce/models/cart_model.dart';
import 'package:indie_commerce/models/payment_model.dart';
import 'package:indie_commerce/navigation/app_routes.dart';
import 'package:indie_commerce/screen/cart/cubits/cart_cubit/cart_cubit.dart';
import 'package:indie_commerce/screen/cart/widgets/cart_item_card_widget.dart';
import 'package:indie_commerce/screen/favorite/add_item_cubit/add_item_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    context.read<CartCubit>().getCartItems(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;
    List<CartModel> listCart = [];
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
      body: BlocListener<AddItemCubit, AddItemState>(
        listener: (context, state) {
          if (state is AddItemCartSuccess) {
            context.read<CartCubit>().getCartItems(uid);
          }
        },
        child: BlocBuilder<CartCubit, CartState>(
          builder: (productContext, productState) {
            return BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CartLoaded) {
                  listCart = state.cartItems;
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 36, left: 16, right: 16),
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItemCardWidget(
                          product: state.cartItems[index],
                          uid: uid,
                        );
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
          child: Column(
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
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      double priceTotal = 0.0;
                      if (state is CartLoaded) {
                        for (var i = 0; i < state.cartItems.length; i++) {
                          priceTotal += (state.cartItems[i].price! *
                              state.cartItems[i].quantity!);
                        }
                        totalPrice = priceTotal;
                        return Text(
                          "\$${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
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
                    "\$0.00",
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
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      double sum = 0.0;
                      if (state is CartLoaded) {
                        for (var i = 0; i < state.cartItems.length; i++) {
                          sum += (state.cartItems[i].price! *
                              state.cartItems[i].quantity!);
                        }
                        return Text(
                          "\$${sum.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  PaymentModel data = PaymentModel(
                      cartItems: listCart,
                      totalPrice: totalPrice.toStringAsFixed(2));
                  context.pushNamed(AppRoutes.nrPayment, extra: data);
                },
                child: Container(
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
              ),
            ],
          )),
    );
  }
}
