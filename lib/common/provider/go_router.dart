import 'package:code_factory_middle/user/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  // watch : 값이 변경 될 때마다 다시 빌드
  // read : 한번만 읽고 값이 변경돼도 다시 빌드하지 않음
  // 현재는 auth는 변경될 경우도 없다.
  final provider = ref.read(authProvider);
  return GoRouter(
    routes: provider.routes,
    initialLocation: '/splash',
    // initialLocation: '/',
    refreshListenable: provider,
    redirect: provider.redirectLogic,
  );
});
