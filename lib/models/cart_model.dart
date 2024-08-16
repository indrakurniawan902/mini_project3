import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  final int? id;
  final String? title;
  final double? price;
  final String? image;
  final int? quantity;

  CartModel({
    this.id,
    this.title,
    this.price,
    this.image,
    this.quantity
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
