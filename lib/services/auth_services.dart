import 'dart:convert';

import 'package:chat/global/enviroment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  late User user;
  bool _isAuthing = false;

  final _storage = const FlutterSecureStorage();

  bool get isAuthing => _isAuthing;
  set isAuthing(bool value) {
    _isAuthing = value;
    notifyListeners();
  }

  // Getters: static form for token
  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    isAuthing = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post(
      Uri.parse('${Enviroments.apiUrl}/login'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    isAuthing = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;
      await _saveToke(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> register(String name, String email, String password) async {
    final data = {
      'name': name,
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.parse('${Enviroments.apiUrl}/login/new'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(resp.body);

    if (resp.statusCode == 200) {
      final registerResponse = loginResponseFromJson(resp.body);
      user = registerResponse.user;
      await _saveToke(registerResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final String? token = await _storage.read(key: 'token');
    print(token);

    if (token == null) {
      return false;
    }

    final resp = await http.get(
      Uri.parse('${Enviroments.apiUrl}/login/renew'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;
      await _saveToke(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _saveToke(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    return await _storage.delete(key: 'token');
  }
}
