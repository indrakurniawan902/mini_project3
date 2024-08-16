import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final int? quantity;
  final Rating? rating;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.quantity,
    this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Rating {
  final double? rate;
  final int? count;

  Rating({
    this.rate,
    this.count,
  });


  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
