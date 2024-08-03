import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:indie_commerce/constant/constant.dart';
import 'package:indie_commerce/models/cart_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  /// singleton
  static final CartService instance = CartService._internal();
  CartService._internal();
  factory CartService() {
    return instance;
  }

  final Dio dio = Dio(
    BaseOptions(baseUrl: Constant.baseUrl),
  );

  Future<List<CartModel>> getCartItemsByUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    try {
      final response = await dio.get('/carts/${decodedToken['sub']}');
      List<CartModel> data = (response.data['products'] as List)
          .map((item) => CartModel.fromJson(item))
          .toList();
      log(response.data.toString());
      log("token: $token");
      log("sub: ${decodedToken['sub']}");
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
