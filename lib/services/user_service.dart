import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:indie_commerce/models/cart_model.dart';
import 'package:indie_commerce/models/user_model.dart';

class UserService {
  /// singleton untukk memastikan bahwa hanya satu instance dari kelas Dio yang akan dipanggil nantinya
  static final UserService instance = UserService._internal();
  UserService._internal();
  factory UserService() {
    return instance;
  }

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> createUser(
      String username, String email, String password) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (response.user != null) {
        firebaseFirestore.collection("users").doc(response.user!.uid).set({
          "uid": response.user!.uid,
          "email": email,
          "username": username,
          "favorites": FieldValue.arrayUnion([])
        });
        return "Success";
      } else {
        return "Error";
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserModel> getUserByEmail(String email) async {
    try {
      final response = await firebaseFirestore
          .collection("users")
          .where("email", isEqualTo: email)
          .get()
          .then((value) => value.docs);
      return UserModel.fromJson(response.first.data());
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> addToFavorite(int productId, String uid) async {
    try {
      List<int> listId = [productId];
      await firebaseFirestore
          .collection("users")
          .doc(uid)
          .update({"favorites": FieldValue.arrayUnion(listId)});
      return "Added to favorites";
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> removeFavorite(int productId, String uid) async {
    try {
      List<int> listId = [productId];
      await firebaseFirestore
          .collection("users")
          .doc(uid)
          .update({"favorites": FieldValue.arrayRemove(listId)});
      return "Favorites removed";
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> addToCart(String uid, CartModel productData) async {
    final isExist = await firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("carts")
        .where("id", isEqualTo: productData.id)
        .get();
    try {
      if (isExist.docs.isNotEmpty) {
        await firebaseFirestore
            .collection("users")
            .doc(uid)
            .collection("carts")
            .doc(productData.id.toString())
            .update({
          "id": productData.id,
          "title": productData.title,
          "price": productData.price,
          "image": productData.image,
          "quantity": FieldValue.increment(1)
        });
      } else {
        await firebaseFirestore
            .collection("users")
            .doc(uid)
            .collection("carts")
            .doc(productData.id.toString())
            .set({
          "id": productData.id,
          "title": productData.title,
          "price": productData.price,
          "image": productData.image,
          "quantity": FieldValue.increment(1)
        });
      }

      return "Added to Cart";
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> removeFromCart(String uid, CartModel productData) async {
    final isExist = await firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("carts")
        .where("id", isEqualTo: productData.id)
        .get();
    try {
      if (isExist.docs.first.data()["quantity"] <= 1) {
        await firebaseFirestore
            .collection("users")
            .doc(uid)
            .collection("carts")
            .doc(productData.id.toString())
            .delete();
      } else {
        await firebaseFirestore
            .collection("users")
            .doc(uid)
            .collection("carts")
            .doc(productData.id.toString())
            .update({
          "id": productData.id,
          "title": productData.title,
          "price": productData.price,
          "image": productData.image,
          "quantity": FieldValue.increment(-1)
        });
      }

      return "Removed from cart";
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
