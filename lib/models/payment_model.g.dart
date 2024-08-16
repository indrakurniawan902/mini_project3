// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      cartItems: (json['cartItems'] as List<dynamic>)
          .map((e) => CartModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as String,
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'cartItems': instance.cartItems,
      'totalPrice': instance.totalPrice,
    };
