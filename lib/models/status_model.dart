import 'package:json_annotation/json_annotation.dart';

part 'status_model.g.dart';

@JsonSerializable()
class StatusModel {
  final int? id;
  final String total;
  final List<Map<String, dynamic>> items;
  final String paymentMethod;
  final String status;
  String? date;

  StatusModel(
      { this.id,
      required this.total,
      required this.items,
      required this.paymentMethod,
      required this.status,
      this.date});

  factory StatusModel.fromJson(Map<String, dynamic> json) =>
      _$StatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusModelToJson(this);
}
