import 'package:daelim_class/config.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // NOTE: 로그인 API 호출
  void _onFetchedApi() async {
    final loginData = {
      'email': '202030307@daelim.ac.kr',
      'password': '202030307',
    };

    final response = await http.post(
      Uri.parse(authUrl),
      body: loginData,
    );

    debugPrint('status: ${response.statusCode}, body: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: _onFetchedApi,
            child: const Text('API 호출'),
          ),
        ),
      ),
    );
  }
}
