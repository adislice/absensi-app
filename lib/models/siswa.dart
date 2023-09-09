class Siswa {
  int? id;
  String? nama;
  String? nis;
  String? tempatLahir;
  String? tanggalLahir;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;

  Siswa(
      {this.id,
      this.nama,
      this.nis,
      this.tempatLahir,
      this.tanggalLahir,
      this.rememberToken,
      this.createdAt,
      this.updatedAt});

  Siswa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    nis = json['nis'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['nis'] = this.nis;
    data['tempat_lahir'] = this.tempatLahir;
    data['tanggal_lahir'] = this.tanggalLahir;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
