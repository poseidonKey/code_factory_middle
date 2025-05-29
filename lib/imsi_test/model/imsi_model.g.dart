// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imsi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImsiModel _$ImsiModelFromJson(Map<String, dynamic> json) => ImsiModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toInt(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$ImsiModelToJson(ImsiModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
    };
