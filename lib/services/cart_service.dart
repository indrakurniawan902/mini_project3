import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indie_commerce/models/cart_model.dart';

class CartService {
  /// singleton
  static final CartService instance = CartService._internal();
  CartService._internal();
  factory CartService() {
    return instance;
  }

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<List<CartModel>> getCartItemsByUserId(String uid) async {
    try {
      final response = await firebaseFirestore.collection("users").doc(uid).collection("carts").get();
      List<CartModel> data = (response.docs as List)
          .map((item) => CartModel.fromJson(item.data()))
          .toList();
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
