import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indie_commerce/models/product_model.dart';
import 'package:indie_commerce/screen/favorite/add_item_cubit/add_item_cubit.dart';
import 'package:indie_commerce/screen/favorite/favorite_cubit/favorite_cubit.dart';
import 'package:indie_commerce/screen/widget/grid_tile.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    context.read<FavoriteCubit>().favoriteProduct(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> data = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FavoriteCubit, FavoriteState>(
              listener: (context, state) {
            if (state is FavoriteSuccess) {
              data = state.favorites;
            }
          }),
          BlocListener<AddItemCubit, AddItemState>(
            listener: (context, state) {
              if (state is AddItemSuccess) {
                context.read<FavoriteCubit>().favoriteProduct(uid);
              }
            },
          )
        ],
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            if (data.isEmpty && state is FavoriteSuccess) {
              return const Center(
                child: Text("No Items Favorites"),
              );
            } else if (state is FavoriteSuccess) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomGridTile(
                  data: state.favorites,
                  isScrool: true,
                ),
              );
            } else if (state is FavoriteError) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is FavoriteLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
