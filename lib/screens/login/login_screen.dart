import 'dart:convert';
import 'package:daelim_class/common/enums/sso_enum.dart';
import 'package:daelim_class/common/extensions/context_extensions.dart';
import 'package:daelim_class/common/widgets/gradient_divider.dart';
import 'package:daelim_class/config.dart';
import 'package:daelim_class/helpers/storage_helper.dart';
import 'package:daelim_class/models/auth_data.dart';
import 'package:daelim_class/routes/app_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  // NOTE: 로그인 API 호출
  void _onFetchedApi() async {}

  // NOTE: 패스워드 재설정
  void _onRecoveryPassword() {}

  // NOTE: 로그인 버튼
  void _onSignIn() async {
    final email = _emailController.text;
    final password = _pwController.text;

    final loginData = {
      'email': email, // '202030307@daelim.ac.kr'
      'password': password, // '202030307'
    };

    final response = await http.post(
      Uri.parse(getTokenUrl),
      body: jsonEncode(loginData),
    );

    final statusCode = response.statusCode;
    final body = utf8.decode(response.bodyBytes);

    if (statusCode != 200) {
      if (mounted) {
        context.showSnackBar(
          content: Text(body),
        );
      }
      return;
    }

    // NOTE: AuthData 로 변환
    final authData = AuthData.fromMap(jsonDecode(body));
    await StorageHelper.setAuthData(authData);
    final savedAuthData = StorageHelper.authData;
    debugPrint(savedAuthData.toString());

    mounted ? context.go(AppScreen.main.toPath) : null;
  }

  // NOTE: SSO 로그인 버튼
  void _onSsoSignIn(SsoEnum type) {
    switch (type) {
      case SsoEnum.google:
      case SsoEnum.apple:
      case SsoEnum.github:
        context.showSnackBarText(text: '준비 중인 기능입니다.');
        break;
    }
  }

  // NOTE: 타이틀 텍스트 위젯
  List<Widget> _buildTitleText() => [
        const Text(
          'Hello Again!',
          style: TextStyle(fontSize: 28),
        ),
        const SizedBox(height: 15),
        const Text(
          'Welcome back you\'ve\nbeen missed!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ];

  // NOTE: 텍스트 입력 위젯들
  List<Widget> _buildTextFields() => [
        _buildTextField(
          controller: _emailController,
          hintText: 'Enter email',
        ),
        const SizedBox(height: 10),
        _buildTextField(
          onObscure: (down) {
            setState(() {
              _isObscure = !down;
            });
          },
          controller: _pwController,
          hintText: 'Password',
          obscure: _isObscure,
        ),
      ];

  // NOTE: 텍스트 입력 위젯
  Widget _buildTextField({
    required TextEditingController controller,
    required hintText,
    bool? obscure,
    Function(bool down)? onObscure,
  }) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        enabledBorder: border,
        focusedBorder: border,
        hintText: hintText,
        suffixIcon: obscure != null
            ? GestureDetector(
                onTapDown: (details) => onObscure?.call(true),
                onTapUp: (details) => onObscure?.call(false),
                child: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
      ),
      obscureText: obscure ?? false,
    );
  }

  // NOTE: SSO 버튼 위젯
  Widget _buildSsoButton({
    required String iconUrl,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(10),
        child: Image.network(iconUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDEDEE2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DefaultTextStyle(
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: context.textTheme.bodyMedium?.color,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity),
                const SizedBox(height: 36),
                ..._buildTitleText(),
                const SizedBox(height: 25),
                ..._buildTextFields(),
                const SizedBox(height: 16),
                // Recovery Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _onRecoveryPassword,
                    child: const Text(
                      'Recovery Password',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                // Sign in
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE46A61),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // On continue with
                const Row(
                  children: [
                    Expanded(child: GradientDivider()),
                    SizedBox(width: 15),
                    Text('On continue with'),
                    SizedBox(width: 15),
                    Expanded(child: GradientDivider(reverse: true)),
                  ],
                ),
                const SizedBox(height: 40),
                // SSO Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSsoButton(
                      onTap: () => _onSsoSignIn(SsoEnum.google),
                      iconUrl: icGoogle,
                    ),
                    _buildSsoButton(
                      onTap: () => _onSsoSignIn(SsoEnum.apple),
                      iconUrl: icApple,
                    ),
                    _buildSsoButton(
                      onTap: () => _onSsoSignIn(SsoEnum.github),
                      iconUrl: icGithub,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
