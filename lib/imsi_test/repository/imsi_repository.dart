import 'package:code_factory_middle/common/const/data.dart';
import 'package:code_factory_middle/common/dio/dio.dart';
import 'package:code_factory_middle/common/model/cursor_pagination_model.dart';
import 'package:code_factory_middle/common/model/pagination_params.dart';
import 'package:code_factory_middle/common/repository/base_pagination_repository.dart';
import 'package:code_factory_middle/imsi_test/model/imsi_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'imsi_repository.g.dart';

final imsiRepositoryProvider = Provider<ImsiRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ImsiRepository(dio, baseUrl: 'http://$ip/imsi');
});

@RestApi()
abstract class ImsiRepository implements IBasePaginationRepository<ImsiModel> {
  factory ImsiRepository(Dio dio, {String baseUrl}) = _ImsiRepository;

  @override
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<ImsiModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
