// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:absensi_app/api/auth_api.dart';
import 'package:absensi_app/router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:absensi_app/components/typography.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        // useMaterial3: true,
        // colorScheme: ColorScheme.fromSwatch(
        //   primarySwatch: Colors.blue,
        //   brightness: Brightness.light,
        // ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        textTheme: appTextTheme,
        
      ),
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
