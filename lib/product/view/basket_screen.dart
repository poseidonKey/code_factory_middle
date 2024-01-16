import 'package:code_factory_middle/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasketScreen extends ConsumerWidget {
  const BasketScreen({super.key});
  static String get routeName => 'basket';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DefaultLayout(
      title: '장바구니',
      child: Column(),
    );
  }
}
