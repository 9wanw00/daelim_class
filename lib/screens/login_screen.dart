import 'dart:convert';

import 'package:daelim_class/config.dart';
import 'package:flutter/material.dart';
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
  void _onFetchedApi() async {
    final loginData = {
      'email': '202030307@daelim.ac.kr',
      'password': '202030307',
    };

    final response = await http.post(
      Uri.parse(authUrl),
      body: jsonEncode(loginData),
    );

    debugPrint('status: ${response.statusCode}, body: ${response.body}');
  }

  // NOTE: 패스워드 재설정
  void _onRecoveryPassword() {}

  // NOTE: 로그인
  void _onSignIn() {}

  // NOTE: 타이틀 텍스트 위젯
  List<Widget> _buildTitleText() => [
        Text(
          'Hello Again!',
          style: GoogleFonts.poppins(
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Welcome back you\'ve\nbeen missed!',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDEDEE2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  child: Text(
                    'Recovery Password',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
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
                  child: Text(
                    'Sign in',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
