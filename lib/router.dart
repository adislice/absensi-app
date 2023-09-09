import 'package:flutter/material.dart';
import 'package:absensi_app/pages/dashboard_page.dart';
import 'package:absensi_app/pages/landing_page.dart';
import 'package:absensi_app/pages/login_page.dart';
import 'package:absensi_app/pages/home_page.dart';
import 'package:absensi_app/pages/presensi_page.dart';
import 'package:absensi_app/pages/rekap_kehadiran_page.dart';
import 'package:absensi_app/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/',
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/landing',
      builder: (context, state) => LandingPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/presensi_sekarang',
      builder: (context, state) => PresensiPage(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, childWidget) {
        return DashboardBasePage(
            location: state.uri.toString(), child: childWidget);
      },
      routes: [
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/home',
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: HomePage(),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/presensi',
          pageBuilder: (context, state) {
            return const NoTransitionPage(
                child: RekapKehadiranPage()
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/profil',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: Center(child: Text('Profil')));
          },
        ),
      ],
    ),
  ],
);
