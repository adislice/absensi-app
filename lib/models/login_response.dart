class LoginResponse {
  int? id;
  String? nama;
  String? nis;
  String? tempatLahir;
  String? tanggalLahir;
  String? rememberToken;
  String? token;
  String? createdAt;
  String? updatedAt;

  LoginResponse(
      {this.id,
      this.nama,
      this.nis,
      this.tempatLahir,
      this.tanggalLahir,
      this.rememberToken,
      this.token,
      this.createdAt,
      this.updatedAt});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    nis = json['nis'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    rememberToken = json['remember_token'];
    token = json['token'];
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
    data['token'] = this.token;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
