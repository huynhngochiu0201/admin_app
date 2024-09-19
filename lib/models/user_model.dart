import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final dynamic avatar;
  final Timestamp? createdAt;
  final String? role;
  UserModel({
    this.id,
    this.name,
    required this.email,
    required this.password,
    this.avatar,
    this.createdAt,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      avatar: json['avatar'],
      createdAt: json['createdAt'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
      'createdAt': Timestamp.now(),
      'role': 'staff',
    };
  }
}
