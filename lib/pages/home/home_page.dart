import 'package:admin_app/services/remote/home_servive.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/models/order_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeService homeService = HomeService();

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                FutureBuilder<List<OrderModel>>(
                  future: homeService.getAllOrders(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error loading orders');
                    } else {
                      int orderCount = snapshot.data?.length ?? 0;
                      return _buildCard(
                        icon: Icons.article,
                        title: 'Order',
                        value: orderCount.toString(),
                        color: Colors.red,
                      );
                    }
                  },
                ),
                FutureBuilder<double>(
                  future: homeService.calculateTotalPrice(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error calculating total price');
                    } else {
                      double totalPrice = snapshot.data ?? 0.0;
                      return _buildCard(
                        icon: Icons.attach_money,
                        title: 'Total Price',
                        value: totalPrice.toStringAsFixed(2),
                        color: Colors.orange,
                      );
                    }
                  },
                ),
                FutureBuilder<int>(
                  future: homeService.calculateTotalProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error calculating total products');
                    } else {
                      int totalProduct = snapshot.data ?? 0;
                      return _buildCard(
                        icon: Icons.shopping_cart,
                        title: 'Total Product',
                        value: totalProduct.toString(),
                        color: Colors.yellow,
                      );
                    }
                  },
                ),
                FutureBuilder<int>(
                  future: homeService.getAllProductsCount(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error loading products count');
                    } else {
                      int allProduct = snapshot.data ?? 0;
                      return _buildCard(
                        icon: Icons.category,
                        title: 'All Product',
                        value: allProduct.toString(),
                        color: Colors.blue,
                      );
                    }
                  },
                ),
                FutureBuilder<int>(
                  future: homeService.getAllServiveCount(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error loading categories count');
                    } else {
                      int allCategory = snapshot.data ?? 0;
                      return _buildCard(
                        icon: Icons.list,
                        title: 'All Service',
                        value: allCategory.toString(),
                        color: Colors.white,
                      );
                    }
                  },
                ),
                FutureBuilder<int>(
                  future: homeService.getAllCategoriesCount(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error loading categories count');
                    } else {
                      int allCategory = snapshot.data ?? 0;
                      return _buildCard(
                        icon: Icons.list,
                        title: 'All Category',
                        value: allCategory.toString(),
                        color: Colors.white,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 30.0,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
