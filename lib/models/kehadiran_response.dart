class KehadiranResponse {
  String? status;
  List<Data>? data;

  KehadiranResponse({this.status, this.data});

  KehadiranResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? siswaId;
  String? tanggal;
  String? jam;
  String? status;

  Data({this.id, this.siswaId, this.tanggal, this.jam, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siswaId = json['siswa_id'];
    tanggal = json['tanggal'];
    jam = json['jam'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siswa_id'] = this.siswaId;
    data['tanggal'] = this.tanggal;
    data['jam'] = this.jam;
    data['status'] = this.status;
    return data;
  }
}
