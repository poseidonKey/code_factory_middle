import 'package:code_factory_middle/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable()
class CursorPagination {
  final CursorPaginationMeta meta;
  final List<RestaurantModel> data;

  CursorPagination({required this.meta, required this.data});
  factory CursorPagination.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationFromJson(json);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({required this.count, required this.hasMore});
  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}
