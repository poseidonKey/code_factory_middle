import 'package:code_factory_middle/common/component/custom_text_form_field.dart';
import 'package:code_factory_middle/common/const/colors.dart';
import 'package:code_factory_middle/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                width: MediaQuery.of(context).size.width * 1 / 3,
              ),
              CustomTextFormField(
                onChanged: (String value) {},
                hintText: '이 메일을 입력',
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                onChanged: (String value) {},
                hintText: '비밀번호를 입력',
                obscureText: true,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('로그인'),
              ),
              ElevatedButton(
                onPressed: () {},
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
