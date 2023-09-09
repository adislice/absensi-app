import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:absensi_app/utils/secrets.dart';
import 'package:absensi_app/utils/shared_pref.dart';
import 'package:absensi_app/models/login_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthApi {
  final _dio = Dio();
  
  Future<LoginResponse> getUserDataByToken(String token) async {
    debugPrint("Saved token: $token");
      try {
        var result = await _dio.get(
          "$API_URL/cek",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }),
        );
        var userData = LoginResponse.fromJson(result.data);
        
        return userData;
      } on DioException catch (e) {
        debugPrint("Error getUserData(): ${e.message.toString()}");
        rethrow;
      } catch (e) {
        rethrow;
      }
  }
}
