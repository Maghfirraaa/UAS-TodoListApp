class User {
  int id;
  String nama;
  String email;
  String password;

  User(
      {required this.id,
      required this.nama,
      required this.email,
      required this.password});

  factory User.fromJson(Map map) {
    return User(
        id: map['id'],
        nama: map['nama'],
        email: map['email'],
        password: map['password']);
  }
}
