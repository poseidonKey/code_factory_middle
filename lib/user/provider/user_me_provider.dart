// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_factory_middle/common/const/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_factory_middle/user/model/user_model.dart';
import 'package:code_factory_middle/user/repository/user_me_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  UserMeStateNotifier({
    required this.storage,
    required this.repository,
  }) : super(UserModelLoading()) {
    //내 정보 가져오기
    getMe();
  }
  Future<void> getMe() async {
    final refreshToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final accessToken = await storage.read(key: REFRESH_TOKEN_KEY);
    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }
    final resp = await repository.getMe();
    state = resp;
  }
}
