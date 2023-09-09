
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:absensi_app/utils/secrets.dart';
import 'package:absensi_app/utils/shared_pref.dart';
import 'package:absensi_app/models/absensi.dart';
import 'package:absensi_app/models/absensi_response.dart';

class AbsensiApi {
  final _dio = Dio();

  Future<AbsensiResponse> setAbsensi({required Absensi dataAbsensi}) async {
    try {
      debugPrint("Absensi: ${dataAbsensi.toJson().toString()}");
      var token = await SharedPref.getApiToken();
      var result = await _dio.post(
        "$API_URL/absensi",
        data: jsonEncode(dataAbsensi.toJson()),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }
        )
      );
      var resultAbsensi = AbsensiResponse.fromJson(result.data);
      return resultAbsensi;
    } on DioException catch (e) {
      var errRes = AbsensiResponse.fromJson(e.response?.data);
      throw errRes;
    }
    catch (e) {
      rethrow;
    }
  }
}