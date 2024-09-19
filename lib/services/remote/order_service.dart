import 'package:admin_app/models/payment_model.dart';
import 'package:admin_app/services/local/define_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PaymentModel>> getPayment() async {
    try {
      final paymentsCollection = await _firestore
          .collection(AppDefineCollection.APP_PAYMENT)
          .orderBy('createdAt', descending: true)
          .get();
      return paymentsCollection.docs
          .map((doc) => PaymentModel.fromJson(doc))
          .toList();
    } catch (e) {
      throw Exception('Error fetching payments: $e');
    }
  }

  Future<void> deletePaymentById(String paymentId) async {
    try {
      await _firestore
          .collection(AppDefineCollection.APP_PAYMENT)
          .doc(paymentId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
