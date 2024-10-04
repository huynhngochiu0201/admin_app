import 'package:admin_app/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all orders
  Future<List<OrderModel>> getAllOrders() async {
    QuerySnapshot snapshot = await _firestore.collection('orders').get();
    return snapshot.docs.map((doc) => OrderModel.fromJson(doc)).toList();
  }

  // Fetch all products
  Future<int> getAllProductsCount() async {
    QuerySnapshot snapshot = await _firestore.collection('products').get();
    return snapshot.size;
  }

  // Fetch all categories
  Future<int> getAllCategoriesCount() async {
    QuerySnapshot snapshot = await _firestore.collection('categories').get();
    return snapshot.size;
  }

  // Calculate the total price of all orders
  Future<double> calculateTotalPrice() async {
    List<OrderModel> orders = await getAllOrders();
    double totalPrice = 0.0;
    for (var order in orders) {
      totalPrice += order.totalPrice ?? 0.0;
    }
    return totalPrice;
  }

  // Calculate the total number of products purchased
  Future<int> calculateTotalProducts() async {
    List<OrderModel> orders = await getAllOrders();
    int totalProducts = 0;
    for (var order in orders) {
      totalProducts += order.totalProduct ?? 0;
    }
    return totalProducts;
  }
}
