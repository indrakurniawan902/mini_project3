// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusModel _$StatusModelFromJson(Map<String, dynamic> json) => StatusModel(
      id: (json['id'] as num?)?.toInt(),
      total: json['total'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      paymentMethod: json['paymentMethod'] as String,
      status: json['status'] as String,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$StatusModelToJson(StatusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'items': instance.items,
      'paymentMethod': instance.paymentMethod,
      'status': instance.status,
      'date': instance.date,
    };
