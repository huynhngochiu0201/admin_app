import 'package:admin_app/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String? uId;
  final String? paymentId;
  final List<CartModel> cartData;
  final double? totalPrice;
  final int? totalProduct;
  final String? customerName;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final String? note;
  final String? paymentMethod;
  final DateTime? createdAt;
  final bool paymentStatus;

  PaymentModel({
    this.uId,
    this.paymentId,
    required this.cartData,
    this.totalPrice,
    this.totalProduct,
    this.customerName,
    this.email,
    this.phoneNumber,
    this.address,
    this.note,
    this.paymentMethod,
    required this.paymentStatus,
    this.createdAt,
  });

  factory PaymentModel.fromJson(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    List<CartModel> cartData = (data['cartData'] as List)
        .map((item) => CartModel.fromJson(item))
        .toList();
    return PaymentModel(
      uId: data['uId'],
      paymentId: data['paymentId'],
      cartData: cartData,
      totalPrice: data['totalPrice'],
      totalProduct: data['totalProduct'],
      customerName: data['customerName'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      address: data['address'],
      note: data['note'],
      paymentMethod: data['paymentMethod'],
      paymentStatus: data['paymentStatus'],
      createdAt: data['createdAt']?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'paymentId': paymentId,
      'cartData': cartData.map((cart) => cart.toJson()).toList(),
      'totalPrice': totalPrice,
      'totalProduct': totalProduct,
      'customerName': customerName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'note': note,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'createdAt': createdAt,
    };
  }
}
