import 'dart:convert';
import 'dart:io';

import 'package:daelim_class/config.dart';
import 'package:daelim_class/helpers/storage_helper.dart';
import 'package:daelim_class/routes/app_screen.dart';
import 'package:daelim_class/scaffold/app_scaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  Future<Map<String, dynamic>> fetchUserData() async {
    final token = StorageHelper.authData!.token;

    final response = await http.post(
      Uri.parse(getTokenUrl),
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );

    final statusCode = response.statusCode;
    final body = utf8.decode(response.bodyBytes);

    if (statusCode != 200) throw Exception('Failed Fetch');

    return jsonDecode(body);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appScreen: AppScreen.setting,
      child: Column(
        children: [
          FutureBuilder(
            future: fetchUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20),
                  child: const CircularProgressIndicator(),
                );
              }

              final error = snapshot.error;
              final userData = snapshot.data;

              String name = '데이터를 불러올 수 없습니다.';
              String studentNumber = '';
              String profileImage = '';

              if (error != null) studentNumber = '$error';

              if (userData != null) {
                name = userData['name'];
                studentNumber = userData['student_number'];
                profileImage = userData['profile_image'];
              }

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(profileImage),
                ),
                title: Text(name),
                subtitle: Text(studentNumber),
              );
            },
          )
        ],
      ),
    );
  }
}
