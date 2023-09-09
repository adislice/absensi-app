

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:absensi_app/models/login_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPref {
  

  static Future<String?> getApiToken() async {
    try {
      var storage = const FlutterSecureStorage();

      var token = await storage.read(key: "API_TOKEN");
      return token;
    } catch (e) {
      debugPrint("Error getApiToken: ${e.toString()}");
      return null;
    }
  }

  static Future<bool> saveApiToken(String token) async {
    try {
      var storage = const FlutterSecureStorage();
      await storage.write(key: 'API_TOKEN', value: token);
      return true;
    } catch (e) {
      debugPrint("Error setApiToken: ${e.toString()}");
      return false;
    }
  }

  static Future<LoginResponse?> getSavedUserData() async {
    try {
      var storage = const FlutterSecureStorage();
      var savedUser = await storage.read(key: "USER_DATA");
      Map<String, dynamic> userMap = json.decode(savedUser!);
      var userData = LoginResponse.fromJson(userMap);
      return userData;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<bool> saveUserData(LoginResponse userData) async {
    try {
      var storage = const FlutterSecureStorage();
      await storage.write(key: "USER_DATA", value: json.encode(userData.toJson()));
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
  
}