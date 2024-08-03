import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:indie_commerce/screen/home/cubit/product_cubit.dart';
import 'package:indie_commerce/screen/widget/grid_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    "All Products",
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];
  List<String> imgPath = [
    "assets/images/all.png",
    "assets/images/electronics.png",
    "assets/images/jewelry.png",
    "assets/images/men.png",
    "assets/images/women.png",
  ];
  int currentIndex = 0;
  @override
  void initState() {
    context.read<ProductCubit>().getAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset("assets/icons/Menu.svg",
                      height: 20, width: 20),
                  SvgPicture.asset("assets/icons/Notification.svg",
                      height: 24, width: 24),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Material(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide()),
                elevation: 4.0,
                shadowColor: const Color(0xFF1E1F2E),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: SvgPicture.asset("assets/icons/search.svg"),
                      hintText: 'What are you looking for ?',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 3.0))),
                ),
              ),
              const SizedBox(height: 37),
              SizedBox(
                height: 170,
                child: CarouselSlider.builder(
                  itemBuilder: (context, index, realIndex) {
                    return Image.asset("assets/images/Carousel.png");
                  },
                  itemCount: 3,
                  options: CarouselOptions(
                    height: 400.0,
                    autoPlay: true,
                    initialPage: 0,
                    viewportFraction: 1,
                    autoPlayInterval: const Duration(seconds: 5),
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Categories",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextButton(onPressed: () {}, child: const Text("See all")),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 95,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          context.read<ProductCubit>().getAllProduct();
                        } else {
                          log("a : ${categories[index]}");
                          context
                              .read<ProductCubit>()
                              .getCategoriesProduct(categories[index]);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 48,
                          backgroundImage: AssetImage(imgPath[index]),
                        ),
                      ),
                    );
                  },
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(height: 26),
              const Text(
                "Products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 16),
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductSuccess) {
                    return CustomGridTile(
                      data: state.allProducts,
                    );
                  } else if (state is ProductError) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
