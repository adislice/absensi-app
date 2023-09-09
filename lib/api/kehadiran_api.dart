
import 'package:dio/dio.dart';
import 'package:absensi_app/utils/secrets.dart';
import 'package:absensi_app/utils/shared_pref.dart';
import 'package:absensi_app/models/kehadiran_response.dart';

class KehadiranApi {
  final _dio = Dio();
  
  Future<KehadiranResponse> getKehadiran() async {
    try {
      var token = await SharedPref.getApiToken();
      var result = await _dio.get(
        "$API_URL/kehadiran",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }
        )
      );
      var dataKehadiran = KehadiranResponse.fromJson(result.data);
      return dataKehadiran;
    } on DioException catch (e) {
      var errRes = KehadiranResponse.fromJson(e.response?.data);
      throw errRes;
    } catch (e) {
      rethrow;
    }
  }
}