import 'package:flutter/material.dart';
import 'package:absensi_app/api/auth_api.dart';
import 'package:absensi_app/utils/shared_pref.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    var token = SharedPref.getApiToken();

    token.then((res) {
      if (res != null) {
        context.go('/home');
      } else {
        context.go('/landing');
      }
    }).catchError((_) {
      context.go('/landing');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator()
              ),
              SizedBox(height: 30.0,),
              // Text("Loading...")
            ],
          ),
        ),
      )
    );
  }
}
