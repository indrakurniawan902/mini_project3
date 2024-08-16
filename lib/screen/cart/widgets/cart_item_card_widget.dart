import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:indie_commerce/models/cart_model.dart';
import 'package:indie_commerce/navigation/app_routes.dart';
import 'package:indie_commerce/screen/favorite/add_item_cubit/add_item_cubit.dart';

class CartItemCardWidget extends StatelessWidget {
  const   CartItemCardWidget({
    super.key,
    required this.product,
    required this.uid
  });
  final CartModel product;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.nrDetail, extra: product.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Image.network(
                    width: 85,
                    height: 85,
                    product.image!,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image);
                    },
                  ),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        product.title.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$ ${product.price}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<AddItemCubit>().removeCart(uid,product);
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    Text(
                      product.quantity.toString(),
                      style: const TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    IconButton(
                      onPressed: () {
                          context.read<AddItemCubit>().addToCart(uid,product);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
