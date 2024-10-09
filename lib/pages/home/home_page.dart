import 'package:admin_app/resources/double_extension.dart';
import 'package:admin_app/services/remote/home_servive.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/models/order_model.dart';
import 'package:shimmer/shimmer.dart'; // Import Shimmer

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<OrderModel>> ordersFuture;
  late Future<double> totalPriceFuture;
  late Future<int> allProductsFuture;
  late Future<int> allServicesFuture;
  late Future<int> allCategoriesFuture;

  final HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      ordersFuture = homeService.getAllOrders();
      totalPriceFuture = homeService.calculateTotalPrice();
      allProductsFuture = homeService.getAllProductsCount();
      allServicesFuture = homeService.getAllServiveCount();
      allCategoriesFuture = homeService.getAllCategoriesCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  FutureBuilder<List<OrderModel>>(
                    future: ordersFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildShimmer(); // Thêm Shimmer
                      } else if (snapshot.hasError) {
                        return const Text('Error loading orders');
                      } else {
                        int orderCount = snapshot.data?.length ?? 0;
                        return _buildCard(
                          icon: Icons.article,
                          title: 'Order',
                          value: orderCount.toString(),
                          color: Colors.white,
                        );
                      }
                    },
                  ),
                  FutureBuilder<double>(
                    future: totalPriceFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildShimmer(); // Thêm Shimmer
                      } else if (snapshot.hasError) {
                        return const Text('Error calculating total price');
                      } else {
                        double totalPrice = snapshot.data ?? 0.0;
                        return _buildCard(
                          icon: Icons.attach_money,
                          title: 'Total Price',
                          value: totalPrice.toVND(),
                          color: Colors.white,
                        );
                      }
                    },
                  ),
                  FutureBuilder<int>(
                    future: allProductsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildShimmer(); // Thêm Shimmer
                      } else if (snapshot.hasError) {
                        return const Text('Error loading products count');
                      } else {
                        int allProduct = snapshot.data ?? 0;
                        return _buildCard(
                          icon: Icons.category,
                          title: 'All Product',
                          value: allProduct.toString(),
                          color: Colors.white,
                        );
                      }
                    },
                  ),
                  FutureBuilder<int>(
                    future: allServicesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildShimmer(); // Thêm Shimmer
                      } else if (snapshot.hasError) {
                        return const Text('Error loading services count');
                      } else {
                        int allService = snapshot.data ?? 0;
                        return _buildCard(
                          icon: Icons.list,
                          title: 'All Service',
                          value: allService.toString(),
                          color: Colors.white,
                        );
                      }
                    },
                  ),
                  FutureBuilder<int>(
                    future: allCategoriesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildShimmer(); // Thêm Shimmer
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
      ),
    );
  }

  // Hàm xây dựng Shimmer
  Widget _buildShimmer() {
    return Shimmer.fromColors(
      //period: const Duration(milliseconds: 2000),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(width: 15.0),
                  Container(
                    width: 100,
                    height: 30,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                height: 30,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
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
                ),
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
