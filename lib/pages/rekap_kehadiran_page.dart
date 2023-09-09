import 'package:flutter/material.dart';
import 'package:absensi_app/api/kehadiran_api.dart';
import 'package:absensi_app/models/kehadiran_response.dart';
import 'package:absensi_app/utils/helpers.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class RekapKehadiranPage extends StatefulWidget {
  const RekapKehadiranPage({super.key});

  @override
  State<RekapKehadiranPage> createState() => _RekapKehadiranPageState();
}

class _RekapKehadiranPageState extends State<RekapKehadiranPage> {
  final KehadiranApi kehadiranApi = KehadiranApi();

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekap Kehadiran'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text("Rekap Kehadiran Anda"),
            FutureBuilder(
              future: kehadiranApi.getKehadiran(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var kehadiran = snapshot.data!.data;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(Helpers.formatDate(kehadiran?[index].tanggal ?? "")),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          // rounded corner
                          borderRadius: BorderRadius.circular(999.0),
                          color: kehadiran?[index].status == "HADIR" ? Colors.green.shade50 : Colors.red.shade50,
                        ),
                        child: Text(kehadiran?[index].status ?? "Tidak Diketahui",
                          style: TextStyle(
                            
                            color: kehadiran?[index].status == "HADIR" ? Colors.green.shade800 : Colors.red.shade800
                          )
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                    ),
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1.0,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("Terjadi kesalahan");
                }
                return Container(
                  margin: const EdgeInsets.all(40.0),
                  child: Center(child: const CircularProgressIndicator()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
