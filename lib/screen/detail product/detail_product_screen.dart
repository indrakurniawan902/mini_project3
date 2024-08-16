import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:indie_commerce/models/cart_model.dart';
import 'package:indie_commerce/models/product_model.dart';
import 'package:indie_commerce/screen/detail%20product/detail_product_cubit/detail_product_cubit.dart';
import 'package:indie_commerce/screen/favorite/add_item_cubit/add_item_cubit.dart';
import 'package:indie_commerce/screen/profile/cubit/profile_cubit.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key, this.productId});

  final int? productId;

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final email = FirebaseAuth.instance.currentUser!.email;
  @override
  void initState() {
    context.read<DetailProductCubit>().getProductById(widget.productId!);
    context.read<ProfileCubit>().getUserByEmail(email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartModel productCart = CartModel();
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final firebaseMessaging = FirebaseMessaging.instance;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Product",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        actions: [
          BlocListener<AddItemCubit, AddItemState>(
            listener: (context, state) {
              if (state is AddItemSuccess) {
                context.read<ProfileCubit>().getUserByEmail(email!);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is UserLoadedState) {
                  bool isFavorite =
                      state.users.favorites!.contains(widget.productId);
                  log(state.toString());
                  log(state.users.favorites.toString());
                  return IconButton(
                    onPressed: () async {
                      if (isFavorite) {
                        context
                            .read<AddItemCubit>()
                            .removeFavorite(widget.productId!, uid);
                        firebaseMessaging
                            .unsubscribeFromTopic(widget.productId.toString());
                      } else {
                        context
                            .read<AddItemCubit>()
                            .addToFavorite(widget.productId!, uid);
                        firebaseMessaging
                            .subscribeToTopic(widget.productId.toString());
                      }
                    },
                    icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<DetailProductCubit, DetailProductState>(
          builder: (context, state) {
            if (state is DetailProductLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Color(0xff1E1F2E),
                  ),
                ),
              );
            } else if (state is DetailProductSuccess) {
              productCart = CartModel(
                  id: state.product.id,
                  image: state.product.image,
                  price: state.product.price,
                  title: state.product.title);
              final ProductModel product = state.product;
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 80),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Image.network(
                        product.image!,
                        width: 360,
                        height: 378,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${product.price}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffFD6867),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xffF88B0B),
                                  ),
                                  Text(
                                    product.rating?.rate.toString() ?? '',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            product.title ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Description",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            product.description ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Color(0xffAEAEAE),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("Produk tidak ditemukan"),
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocListener<AddItemCubit, AddItemState>(
        listener: (context, state) {
          if (state is AddItemCartSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: GestureDetector(
          onTap: () {
            context.read<AddItemCubit>().addToCart(uid, productCart);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 65, right: 65, bottom: 18),
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 9),
            alignment: Alignment.center,
            height: 47,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: const Color(0xff1E1F2E),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "Add To Cart",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
