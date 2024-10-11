class UserModel {
  String? id;
  String? name;
  String? email;
  String? avatar;
  String? role;

  UserModel();

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel()
    ..id = json['id'] as String?
    ..name = json['name'] as String?
    ..email = json['email'] as String?
    ..avatar = json['avatar'] as String?
    ..role = json['staff'] as String?;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'role': role,
    };
  }
}
