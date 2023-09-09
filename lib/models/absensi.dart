class Absensi {
  String? kode;
  String? tanggal;
  String? jam;

  Absensi({this.kode, this.tanggal, this.jam});

  Absensi.fromJson(Map<String, dynamic> json) {
    kode = json['kode'];
    tanggal = json['tanggal'];
    jam = json['jam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode'] = this.kode;
    data['tanggal'] = this.tanggal;
    data['jam'] = this.jam;
    return data;
  }
}