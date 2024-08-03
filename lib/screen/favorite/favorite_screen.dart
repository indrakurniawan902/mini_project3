import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:indie_commerce/models/product_model.dart';
import 'package:indie_commerce/screen/home/cubit/product_cubit.dart';
import 'package:indie_commerce/screen/widget/grid_tile.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final dataFavorite = Hive.box("favorites").keys.toList();
  @override
  void initState() {
    log(dataFavorite.toString());
    context.read<ProductCubit>().getAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (dataFavorite.isEmpty) {
            return const Center(
              child: Text("No Items Favorites"),
            );
          } else if (state is ProductSuccess) {
            List<ProductModel> filteredData = [];
            for (var i = 0; i < dataFavorite.length; i++) {
              final data = state.allProducts
                  .where(
                    (element) => element.id == dataFavorite[i],
                  )
                  .toList();
              filteredData.addAll(data);
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomGridTile(
                data: filteredData,
                isScrool: true,
              ),
            );
          } else if (state is ProductError) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
