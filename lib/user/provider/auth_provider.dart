import 'package:code_factory_middle/user/model/user_model.dart';
import 'package:code_factory_middle/user/provider/user_me_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
  // splashScreen을 둔 이유는 앱을 처음 시작했을 때 토큰이 존재하는지 확인하고
  // 이에 따라 로그인 스크린으로 보낼지, 홈스크린으로 보내줄지 확인하는 과정이 필요
  String? redirectLogic(GoRouterState state) {
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
}
