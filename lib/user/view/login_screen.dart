import 'dart:convert';
import 'package:code_factory_middle/common/component/custom_text_form_field.dart';
import 'package:code_factory_middle/common/const/colors.dart';
import 'package:code_factory_middle/common/const/data.dart';
import 'package:code_factory_middle/common/layout/default_layout.dart';
import 'package:code_factory_middle/common/secure_storage/secure_storage.dart';
import 'package:code_factory_middle/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    //localhost
    // const emulatorIp = '10.0.2.2:3000';
    // const simulatorIp = '127.0.0.1:3000';
    // final ip = Platform.isIOS ? simulatorIp : emulatorIp;
    return DefaultLayout(
        child: SingleChildScrollView(
      // drag 했을 때 자판 없애기
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Title(),
              const SizedBox(
                height: 16,
              ),
              const _SubTitle(),
              Image.asset(
                'asset/img/misc/logo.png',
                width: MediaQuery.of(context).size.width * 2 / 3,
              ),
              CustomTextFormField(
                onChanged: (String value) {
                  username = value;
                },
                hintText: '이 메일을 입력',
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                onChanged: (String value) {
                  password = value;
                },
                hintText: '비밀번호를 입력',
                obscureText: true,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  // const rawString = 'test@codefactory.ai:testtest';
                  final rawString = '$username:$password';
                  Codec<String, String> stringToBase64 = utf8.fuse(base64);
                  // final rawString = '$username:$password';
                  String token = stringToBase64.encode(rawString);
                  final resp = await dio.post(
                    'http://$ip/auth/login',
                    options: Options(
                      headers: {
                        'authorization': 'Basic $token',
                      },
                    ),
                  );
                  // print(resp.data);
                  final refreshToken = resp.data['refreshToken'];
                  final accessToken = resp.data['accessToken'];
                  final storage = ref.read(secureStorageProvider);
                  await storage.write(
                      key: REFRESH_TOKEN_KEY, value: refreshToken);
                  await storage.write(
                      key: ACCESS_TOKEN_KEY, value: accessToken);

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RootTab(),
                    ),
                  );
                },
                child: const Text('로그인'),
              ),
              ElevatedButton(
                // refresh token을 이용해 access token 받아오기
                onPressed: () async {},
                child: const Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
