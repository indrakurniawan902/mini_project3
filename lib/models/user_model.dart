import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? uid;
  final String? email;
  final String? username;
  final List<int>? favorites;

  UserModel({
    this.uid,
    this.email,
    this.username,
    this.favorites
  });

  factory UserModel.fromJson(Map<String,dynamic> json) => _$UserModelFromJson(json);

  Map<String,dynamic> toJson() => _$UserModelToJson(this);

}
