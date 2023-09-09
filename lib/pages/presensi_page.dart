// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:absensi_app/api/absensi_api.dart';
import 'package:absensi_app/components/my_button.dart';
import 'package:camera/camera.dart';
import 'package:absensi_app/models/absensi.dart';
import 'package:absensi_app/models/absensi_response.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;

class PresensiPage extends StatefulWidget {
  const PresensiPage({super.key});

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  late CameraController _cameraController;
  bool _cameraInitialized = false;
  String _detectedCode = "";
  bool _isLoading = false;
  bool _isSukses = false;
  final AbsensiApi absensiApi = AbsensiApi();

  // init camera
  Future<void> initCamera() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
    if (status.isGranted) {
      List<CameraDescription> cameras = await availableCameras();
      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.high,
      );
      try {
        await _cameraController.initialize().then((_) {
          if (!mounted) return;
          setState(() {});
          setState(() {
            _cameraInitialized =
                true; // updating the flag after camera is initialized
          });
        });
      } on CameraException catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  void initState() {
    // initCamera();

    super.initState();
  }

  // @override
  // void dispose() {
  //   _cameraController.dispose();
  //   super.dispose();
  // }

  void sendPresensi(String kodeEncrypted) {
    setState(() {
      _isLoading = true;
    });
    // get current time in format "HH:mm:ss"
    var now = DateTime.now();
    var jam = "${now.hour}:${now.minute}:${now.second}";
    // get current date in format "yyyy-MM-dd"
    var date = DateFormat("yyyy-MM-dd").format(now);
    var dataAbsensi = Absensi(kode: kodeEncrypted, tanggal: date, jam: jam);
    absensiApi.setAbsensi(dataAbsensi: dataAbsensi).then((res) {
      setState(() {
        _isSukses = true;
      });
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
              title: Text("Berhasil"),
              content: Text(
                res.message.toString(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Baik"),
                )
              ]),
        );
      }
    }).catchError((e) {
      if (e is AbsensiResponse) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Gagal"),
              content: Text(e.message.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Baik"),
                ),
              ],
            ),
          );
        }
      }
    }).whenComplete(
      () => setState(() {
        _isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presensi'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Scan Kode QR Untuk Melakukan Presensi',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Align(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withAlpha(50),
                    width: 4.0),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // border: Border.all(
                  //   color: Theme.of(context).colorScheme.primary.withAlpha(200),
                  // ),
                ),
                child: _isLoading
                    ? Center(
                        child: SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : _isSukses
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle_rounded,
                                    color: Colors.green.shade400,
                                    size: 50.0
                                ),
                                SizedBox(height: 20.0),
                                Text("Absensi Berhasil. Terima Kasih."),
                              ],
                            ),
                          )
                        : MobileScanner(
                            // fit: BoxFit.contain,
                            controller: MobileScannerController(
                              detectionSpeed: DetectionSpeed.normal,
                              detectionTimeoutMs: 500,
                              facing: CameraFacing.back,
                              torchEnabled: false,
                            ),
                            onDetect: (capture) {
                              final List<Barcode> barcodes = capture.barcodes;
                              final Uint8List? image = capture.image;
                              for (final barcode in barcodes) {
                                debugPrint(
                                    'Barcode found! ${barcode.rawValue}');
                                setState(() {
                                  _detectedCode = barcode.rawValue!;
                                });
                                if (!_isSukses) {
                                  sendPresensi(barcode.rawValue!);
                                }
                              }
                            },
                          ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.image_outlined),
              label: Text("Unggah Gambar"),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size.fromHeight(48.0)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
