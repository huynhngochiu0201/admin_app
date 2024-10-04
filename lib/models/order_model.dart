import 'package:admin_app/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? userId;
  final String? userName;
  final List<CartModel> cartData;
  final double? totalPrice;
  final int? totalProduct;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final DateTime? createdAt;

  OrderModel({
    this.userId,
    this.userName,
    required this.cartData,
    this.totalPrice,
    this.totalProduct,
    this.email,
    this.phoneNumber,
    this.address,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'uId': userId,
      'userName': userName,
      'cartData': cartData.map((cart) => cart.toJson()).toList(),
      'totalPrice': totalPrice,
      'totalProduct': totalProduct,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    };
  }

  factory OrderModel.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return OrderModel(
      userId: data['uId'] as String?,
      userName: data['userName'] as String?,
      cartData: (data['cartData'] as List<dynamic>)
          .map((item) => CartModel.fromJson(item))
          .toList(),
      totalPrice: (data['totalPrice'] as num?)?.toDouble(),
      totalProduct: data['totalProduct'] as int?,
      email: data['email'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      address: data['address'] as String?,
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
    );
  }
}