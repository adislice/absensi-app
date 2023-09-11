import 'package:absensi_app/components/my_button.dart';
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  // Text("Filter Bulan:"),
                  // SizedBox(width: 10.0),
                  Expanded(
                    child: DropdownButtonFormField(
                        hint: Text("Pilih Bulan"),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_month),
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          border: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        isDense: true,
                        // decoration: InputDecoration(
                        //   border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        //     borderSide: BorderSide(color: Colors.grey.shade100),
                        //   ),
                        // ),
                        items: [
                          DropdownMenuItem(
                            child: Text("Januari"),
                            value: "01",
                          ),
                          DropdownMenuItem(
                            child: Text("Januari"),
                            value: "02",
                          ),
                        ],
                        onChanged: (_) {}),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                        hint: Text("Pilih Status"),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.filter_alt_outlined),
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          border: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        isDense: true,
                        // decoration: InputDecoration(
                        //   border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        //     borderSide: BorderSide(color: Colors.grey.shade100),
                        //   ),
                        // ),
                        items: [
                          DropdownMenuItem(
                            child: Text("Status"),
                            value: "01",
                          ),
                          DropdownMenuItem(
                            child: Text("Hadir"),
                            value: "02",
                          ),
                          DropdownMenuItem(
                            child: Text("Terlambat"),
                            value: "03",
                          ),
                        ],
                        onChanged: (_) {}),
                  ),
                  // ElevatedButton(onPressed: (){}, child: Text("Tampilkan"))
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: FilledButton(child: Text("Tampilkan"), onPressed: (){FocusScope.of(context).requestFocus(FocusNode());}),
            // ),
            // Text("Rekap Kehadiran Anda"),
            Divider(),
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
                      leading: Container(
                        // padding: EdgeInsets.all(10.0),
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99999.9),
                          color: kehadiran?[index].status == "HADIR"
                              ? Colors.green.shade400
                              : Colors.red.shade400,
                        ),
                        child: Center(
                          child: Text(
                            kehadiran?[index].tanggal?.split('-')[2] ?? "",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                                Helpers.formatDate(kehadiran?[index].tanggal ?? ""),
                              ),
                              Text("Masuk 08:00 • Pulang 16:00",
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey.shade700, fontWeight: FontWeight.normal),
                              )
                        ],
                      ),
                      // trailing: Container(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 10.0, vertical: 4.0),
                      //   decoration: BoxDecoration(
                      //     // rounded corner
                      //     borderRadius: BorderRadius.circular(999.0),
                      //     color: kehadiran?[index].status == "HADIR"
                      //         ? Colors.green.shade50
                      //         : Colors.red.shade50,
                      //   ),
                      //   child: Text(
                      //       kehadiran?[index].status ?? "Tidak Diketahui",
                      //       style: TextStyle(
                      //           color: kehadiran?[index].status == "HADIR"
                      //               ? Colors.green.shade800
                      //               : Colors.red.shade800)),
                      // ),
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
