// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'username': instance.username,
      'favorites': instance.favorites,
    };
