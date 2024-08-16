import 'package:indie_commerce/models/cart_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class PaymentModel {
  final List<CartModel> cartItems;
  final String totalPrice;

  PaymentModel({required this.cartItems, required this.totalPrice});

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
