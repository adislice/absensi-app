import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart' show IterableExtension;

List<BottomNavigationBarItem> navItems = [
  BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
  BottomNavigationBarItem(icon: Icon(Icons.date_range), label: 'Presensi'),
  BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
];

class DashboardBasePage extends StatefulWidget {
  final Widget child;
  final String location;
  const DashboardBasePage(
      {super.key, required this.child, required this.location});

  @override
  State<DashboardBasePage> createState() => _DashboardBasePageState();
}

class _DashboardBasePageState extends State<DashboardBasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Aplikasi Apik'),
      // ),
      // body: widget.child,
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.location == '/home'
            ? 0
            : widget.location == '/presensi'
                ? 1
                : widget.location == '/profil'
                    ? 2
                    : 0,
        onTap: onTap,
        items: navItems,
      ),
    );
  }

  void onTap(int value) {
    switch (value) {
      case 0:
        return context.go('/home');
      case 1:
        return context.go('/presensi');
      case 2:
        return context.go('/profil');
      default:
        return context.go('/home');
    }
  }
}
