import 'package:code_factory_middle/user/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  final provider = ref.watch(authProvider);
  return GoRouter(
    routes: provider.routes,
    initialLocation: '/splash',
    refreshListenable: provider,
    redirect: provider.redirectLogic,
  );
});
