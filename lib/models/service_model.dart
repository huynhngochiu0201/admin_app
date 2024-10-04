import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String id;
  final String? name;
  final String? image;
  final double? price;
  final String? description; // Include description
  final Timestamp? createAt;

  ServiceModel({
    required this.id,
    this.name,
    this.image,
    this.createAt,
    this.price,
    this.description, // Initialize description
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?, // Get description
      createAt: json['createAt'] as Timestamp?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'description': description, // Include description
      'createAt': createAt,
    };
  }
}
