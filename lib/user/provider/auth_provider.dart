import 'dart:async';

import 'package:code_factory_middle/common/view/root_screen.dart';
import 'package:code_factory_middle/common/view/splash_screen.dart';
import 'package:code_factory_middle/order/view/order_done_screen.dart';
import 'package:code_factory_middle/product/view/basket_screen.dart';
import 'package:code_factory_middle/restaurant/view/restaurant_detail_screen.dart';
import 'package:code_factory_middle/user/model/user_model.dart';
import 'package:code_factory_middle/user/provider/user_me_provider.dart';
import 'package:code_factory_middle/user/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;
  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }
  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootScreen.routeName,
          builder: (context, state) => const RootScreen(),
          routes: [
            GoRoute(
              path: 'restaurant/:rid',
              name: RestaurantDetailScreen.routeName,
              builder: (_, state) =>
                  RestaurantDetailScreen(id: state.pathParameters['rid']!),
            ),
          ],
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/order_don',
          name: OrderDoneScreen.routeName,
          builder: (context, state) => const OrderDoneScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/basket',
          name: BasketScreen.routeName,
          builder: (context, state) => const BasketScreen(),
        ),
      ];
  // splashScreen을 둔 이유는 앱을 처음 시작했을 때 토큰이 존재하는지 확인하고
  // 이에 따라 로그인 스크린으로 보낼지, 홈스크린으로 보내줄지 확인하는 과정이 필요
  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.location == '/login';

    // user 정보가 없는데 로그인 중이면 그대로 로그인 페이지에 두고
    // 로그인 중이 아니라면 로그인 페이지로 이동
    if (user == null) {
      return logginIn ? null : '/login';
    }

    // user가 null 이 아님

    // userModel의
    // 사용자 정보가 있는 상태이면
    // 로그인 중이거나 현재 위치가 SplashScreen이면 홈으로 이동
    if (user is UserModel) {
      return logginIn || state.location == '/splash' ? '/' : null;
    }
    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }
    return null;
  }

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }
}
