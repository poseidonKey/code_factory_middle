import 'package:code_factory_middle/common/model/cursor_pagination_model.dart';
import 'package:code_factory_middle/common/provider/pagination_provider.dart';
import 'package:code_factory_middle/imsi_test/model/imsi_model.dart';
import 'package:code_factory_middle/imsi_test/repository/imsi_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imsiProvider =
    StateNotifierProvider<ImsiStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(imsiRepositoryProvider);
  final notifier = ImsiStateNotifier(ref: ref, repository: repo);
  return notifier;
});

class ImsiStateNotifier extends PaginationProvider<ImsiModel, ImsiRepository> {
  final Ref ref;

  ImsiStateNotifier({required this.ref, required super.repository});
}
