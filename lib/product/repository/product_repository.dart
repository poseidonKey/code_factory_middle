import 'package:code_factory_middle/common/const/data.dart';
import 'package:code_factory_middle/common/dio/dio.dart';
import 'package:code_factory_middle/common/model/cursor_pagination_model.dart';
import 'package:code_factory_middle/common/model/pagination_params.dart';
import 'package:code_factory_middle/common/repository/base_pagination_repository.dart';
import 'package:code_factory_middle/product/model/product_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'product_repository.g.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return ProductRepository(dio, baseUrl: 'http://$ip/product');
  },
);

// http://$ip/product
@RestApi()
abstract class ProductRepository<T>
    implements IBasePaginationRepository<ProductModel> {
  factory ProductRepository(Dio dio, {String baseUrl}) = _ProductRepository;

  @override
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<ProductModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
