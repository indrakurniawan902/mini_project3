import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:indie_commerce/models/product_model.dart';
import 'package:indie_commerce/navigation/app_routes.dart';

class CustomGridTile extends StatelessWidget {
  final List<ProductModel> data;
  final bool? isScrool;

  const CustomGridTile({super.key, required this.data, this.isScrool});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: isScrool == true
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 210 / 315,
        crossAxisCount: 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            int id = data[index].id!;
            context.pushNamed(AppRoutes.nrDetail, extra: id);
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF9C9C9C),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    height: 140,
                    width: 160,
                    child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(data[index].image!))),
                Text(
                  data[index].title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Icon(
                      size: 20,
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Text(data[index].rating!.rate!.toString()),
                    Text(
                      " (${data[index].rating!.count!})",
                    ),
                  ],
                ),
                Text(
                  " \$ ${data[index].price}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
