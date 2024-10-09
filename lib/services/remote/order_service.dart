import 'package:admin_app/models/order_model.dart';
import 'package:admin_app/services/local/order_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<OrderModel>> getAllOrders() {
    return _firestore
        .collection('orders')
        .orderBy('createdAt',
            descending: true) // Sort by createdAt in descending order
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => OrderModel.fromJson(doc)).toList();
    });
  }

  // Delete an order by ID
  Future<void> deleteOrder(String orderId) async {
    await _firestore.collection('orders').doc(orderId).delete();
  }

  // Update order status
  Future<void> updateOrderStatus1(String orderId, String status) async {
    // Validate the status before updating
    if (status == OrderStatus.received ||
        status == OrderStatus.inTransit ||
        status == OrderStatus.cancelled) {
      await _firestore
          .collection('orders')
          .doc(orderId)
          .update({'status': status});
    } else {
      throw Exception("Invalid status");
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': newStatus, // Update the status field in Firestore
      });
    } catch (e) {
      print('Error updating order status: $e');
      throw Exception('Failed to update order status');
    }
  }
}
