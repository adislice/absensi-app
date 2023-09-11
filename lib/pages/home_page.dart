// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:absensi_app/api/auth_api.dart';
import 'package:absensi_app/utils/shared_pref.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../components/section_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _timeString;
  late String _dateString;
  late Timer _timer;
  String? _displayName;
  final _authApi = AuthApi();

  @override
  void initState() {
    _timeString = _formatTime(DateTime.now());
    _dateString = _formatDate(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) => _getTime());
    SharedPref.getSavedUserData().then((user) {
      if (user != null) {
        setState(() {
          _displayName = user.nama;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatTime(now);
    final String formattedDate = _formatDate(now);
    setState(() {
      _timeString = formattedTime;
      _dateString = formattedDate;
    });
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            primary: true,
            collapsedHeight:
                kToolbarHeight + MediaQuery.of(context).padding.top,
            title: Text(
              "Home",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            centerTitle: true,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.0,
              collapseMode: CollapseMode.pin,
              titlePadding: EdgeInsets.all(20.0),
              background: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Selamat datang kembali",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0,
                                  ),
                        ),
                        (_displayName != null
                            ? Text(
                                _displayName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0),
                              )
                            : Shimmer.fromColors(
                                period: Duration(milliseconds: 800),
                                baseColor: Colors.grey.shade300.withAlpha(100),
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: Colors.white.withAlpha(100),
                                  ),
                                  width: 200.0,
                                  height: 30.0,
                                  margin: const EdgeInsets.only(
                                    bottom: 4.0,
                                    top: 4.0,
                                  ),
                                ),
                              )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 130.0,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Card(
                        surfaceTintColor: Theme.of(context).colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${_timeString}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 35.0),
                                      ),
                                      Text("$_dateString")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      context.push('/presensi_sekarang');
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.qr_code_scanner_rounded,
                                          size: 38.0,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        Text("Presensi")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SectionTitle(title: "Informasi & Pengumuman"),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InformasiCard(
                  index: index,
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class InformasiCard extends StatelessWidget {
  final int index;
  const InformasiCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.withAlpha(50),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.bookmark_outline_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 14.0,
                  ),
                  Text(
                    "AKADEMIK",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          letterSpacing: 1.2,
                        ),
                    textScaleFactor: 0.9,
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                "Jadwal Ujian Akhir Semester TA 2023/2024 $index",
                style: Theme.of(context).textTheme.titleLarge,
                textScaleFactor: 0.8,
              ),
              SizedBox(height: 10.0),
              Text(
                "5 hari yang lalu",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(180),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
