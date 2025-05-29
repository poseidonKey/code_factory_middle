import 'package:code_factory_middle/common/component/pagination_list_view.dart';
import 'package:code_factory_middle/imsi_test/model/imsi_model.dart';
import 'package:code_factory_middle/imsi_test/provider/imsi_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImsiScreen extends ConsumerWidget {
  const ImsiScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView<ImsiModel>(
        itemBuilder: <ImsiModel>(_, inde, model) {
          return Container();
        },
        provider: imsiProvider);
  }
}
