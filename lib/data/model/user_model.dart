class UserModel {
  final int id;
  final String email;

  UserModel({required this.id, required this.email});

  factory UserModel.from(Map<String, dynamic> json) {
    return UserModel(id: json['id'], email: json['email']);
  }
}
