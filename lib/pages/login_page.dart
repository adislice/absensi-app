// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:absensi_app/api/auth_api.dart';
import 'package:absensi_app/utils/shared_pref.dart';
import 'package:absensi_app/models/login_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:absensi_app/utils/secrets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _dio = Dio();
  final _formKey = GlobalKey<FormState>();
  bool _enableBtn = false;
  String nis = "";
  String password = "";
  bool _loading = false;
  final storage = FlutterSecureStorage();
  final authApi = AuthApi();

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _loading = true;
      _enableBtn = false;
    });
    try {
      var loginCredential = {"nis": nis, "password": password};
      var result = await _dio.post(
        "$API_URL/login",
        data: jsonEncode(loginCredential),
      );

      var loginRes = LoginResponse.fromJson(result.data);
      if (loginRes.token != null) {
        await SharedPref.saveApiToken(loginRes.token!);
        await SharedPref.saveUserData(loginRes);
        if (mounted) {
          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Login Berhasil"),
                content: Text("Selamat Datang ${loginRes.nama}"),
                actions: [
                  TextButton(
                    onPressed: () => context.go("/home"),
                    child: Text("Baik"),
                  ),
                ],
              );
            },
          );
        }
      }
      debugPrint(loginRes.token);
    } on DioException catch (e) {
      if (e.response?.data != null) {
        if (!mounted) {
          return;
        }
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Login Gagal"),
                content: Text(
                    "Kesalahan server. Silahkan ulangi beberapa saat lagi!"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Baik"))
                ],
              );
            });
      }
    } finally {
      setState(() {
        _loading = false;
        _enableBtn = true;
      });
    }
  }

  Future<LoginResponse?> _getUserData() async {
    String? token = await storage.read(key: "API_TOKEN");
    if (token != null) {
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
        storage.write(key: "USER_DATA", value: json.encode(userData.toJson()));
        return userData;
      } on DioException catch (e) {
        debugPrint("Error getUserData(): ${e.stackTrace.toString()}");
        rethrow;
      } catch (e) {
        rethrow;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        scrolledUnderElevation: 1.0,
        surfaceTintColor: Colors.white,
      ),
      // extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30.0),
              Text(
                'Login',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(200),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Center(
                child: Image.asset(
                  'assets/user_login_illustration.png',
                  width: 300.0,
                  height: 300.0,
                ),
              ),
              Form(
                key: _formKey,
                onChanged: () => setState(
                  () => _enableBtn = _formKey.currentState!.validate(),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Nomor Induk Siswa',
                        prefixIcon: Icon(Icons.alternate_email_rounded),
                        filled: true,
                        fillColor: Colors.grey.shade200.withAlpha(150),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Can\'t be empt';
                        }
                        if (text.length < 4) {
                          return 'Too short';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      maxLines: 1,
                      onChanged: (value) => setState(() => nis = value),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        filled: true,
                        fillColor: Colors.grey.shade200.withAlpha(150),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Can\'t be empty';
                        }

                        return null;
                      },
                      onChanged: (value) => setState(() => password = value),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              FilledButton(
                onPressed: _enableBtn ? () => _login() : null,
                child: _loading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      )
                    : Text("Login"),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size.fromHeight(48.0)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
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
