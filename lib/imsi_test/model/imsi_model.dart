import 'package:code_factory_middle/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'imsi_model.g.dart';

@JsonSerializable()
class ImsiModel implements IModelWithId {
  @override
  final String id;
  final String name;
  final int price;
  final String description;
  ImsiModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.description});

  factory ImsiModel.fromJson(Map<String, dynamic> json) =>
      _$ImsiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImsiModelToJson(this);
}
