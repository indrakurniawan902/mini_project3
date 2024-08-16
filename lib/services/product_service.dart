import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indie_commerce/models/product_model.dart';

class ProductService {
  /// singleton
  static final ProductService instance = ProductService._internal();
  ProductService._internal();
  factory ProductService() {
    return instance;
  }

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<ProductModel> getProductById(int productId) async {
    try {
      final response = await firebaseFirestore
          .collection("products")
          .where("id", isEqualTo: productId)
          .get()
          .then((value) => value.docs);
      return ProductModel.fromJson(response.first.data());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ProductModel>> getAllProduct() async {
    try {
      final response = await firebaseFirestore.collection("products").get();
      List<ProductModel> data =
          response.docs.map((e) => ProductModel.fromJson(e.data())).toList();
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ProductModel>> getCategoriesProduct(String category) async {
    try {
      final response = await firebaseFirestore
          .collection("products")
          .where("category", isEqualTo: category)
          .get();
      List<ProductModel> data =
          response.docs.map((e) => ProductModel.fromJson(e.data())).toList();
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ProductModel>> getFavorites(String uid) async {
    final userFav = await firebaseFirestore.collection("users").doc(uid).get();
    List productId = userFav.data()?["favorites"] ?? [];
    List<ProductModel> data = [];
    try {
      for (int id in productId) {
        final response = await firebaseFirestore
            .collection("products")
            .where("id", isEqualTo: id)
            .get();
        data =
            response.docs.map((e) => ProductModel.fromJson(e.data())).toList();
      }
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
