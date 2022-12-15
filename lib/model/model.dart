class Data {
  String nama;
  String detail;
  String gambar;

  Data({required this.nama, required this.detail, required this.gambar});

  factory Data.fromJson(Map map) {
    return Data(
        nama: map['nama'], detail: map['detail'], gambar: map['gambar']);
  }
}
