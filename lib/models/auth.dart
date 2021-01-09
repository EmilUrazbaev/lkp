import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  static const String authUrl = 'https://cards-info.ru/lkn/apim/';
  static const String secret =
      'po8yni7p7045lqg8kgp79h2mgf8jyfi6kv5gy3nk7xwwetcqp3';
  String mainUrl;

  String token;
  String contractId;
  bool isAuthenicated = false;
  //bool isAuth = false;
  bool get isAuth {
    return isAuthenicated;
  }

  Future<String> getMainUrl() async {
    final getUrl =
        '${authUrl}url_find.php?action=api_url_find&token=$token&key=$secret';

    final response = await http.get(getUrl);
    final preUrl = json.decode(response.body)[0] as String;
    return preUrl;
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    token = extractedUserData['token'];
    contractId = extractedUserData['contractId'];
    mainUrl = extractedUserData['mainUrl'];
    isAuthenicated = true;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    token = null;
    contractId = null;
    isAuthenicated = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  Future<void> signin(String contractId, String token) async {
    // print(contractId);
    // print(token);
    final getUrl =
        '${authUrl}url_find.php?action=api_url_find&token=$token&key=$secret';
    print('geturl:$getUrl');
    final authResponse = await http.get(getUrl);
    final preUrl = json.decode(authResponse.body)['url'] as String;
    print(preUrl);
    mainUrl = preUrl;

    final url =
        "$preUrl/api_select.php?action=jurid&cont=$contractId&key=$token";
    print('preurl:$url');

    try {
      final response = await http.get(url);
      print(response);
      if (response.body != 'Доступ запрещен') {
        print('Authenicated');
        this.token = token;
        this.contractId = contractId;
        isAuthenicated = true;
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
            {'token': token, 'contractId': contractId, 'mainUrl': mainUrl});
        prefs.setString('userData', userData);
      } else {
        throw HttpException('Неправильный логин или пароль!');
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}

//save sqlite

//login
