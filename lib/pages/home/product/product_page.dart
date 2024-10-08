import 'package:admin_app/models/product_model.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/constants/app_color.dart';
import 'package:admin_app/pages/home/product/widget/add_product.dart';
import 'package:admin_app/pages/home/product/widget/item_product.dart';
import 'package:admin_app/resources/double_extension.dart';
import 'package:admin_app/services/remote/product_service.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductModel> _products = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      ProductService productService = ProductService();
      List<ProductModel> products =
          await productService.fetchAllProductsByCreateAt();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshProducts() async {
    await _fetchProducts(); // Call the fetchProducts method to refresh the list
  }

  Future<void> _deleteProduct(ProductModel product) async {
    try {
      ProductService productService = ProductService();
      await productService
          .deleteProductById(product.id); // Assuming this method exists
      _fetchProducts(); // Refresh the list after deletion
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshProducts, // Function to call when pulling to refresh
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 20.0),
          child: Column(
            children: [
              CrElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(builder: (context) => const AddProduct()),
                  )
                      .then((value) {
                    // After adding a new product, fetch the products again
                    _fetchProducts();
                  });
                },
                text: 'Add Product',
                color: Colors.blue,
                borderColor: Colors.white,
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage != null
                        ? Center(child: Text('Error: $_errorMessage'))
                        : _products.isEmpty
                            ? const Center(child: Text('No products available'))
                            : DynamicHeightGridView(
                                builder: (context, index) {
                                  ProductModel product = _products[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ItemProduct(
                                            product: product,
                                            onDelete:
                                                _deleteProduct, // Pass the delete callback
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                              spreadRadius: 0,
                                              blurRadius: 3,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                          horizontal: 10.0)
                                                      .copyWith(top: 10),
                                              child: Container(
                                                height: 100,
                                                width: size.width,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    product.image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5.0),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      maxLines: 1,
                                                      product.name,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      maxLines: 1,
                                                      product.categoryId,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                        'Quantity: ${product.quantity}'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: 40.0,
                                                  width: 110.0,
                                                  decoration: BoxDecoration(
                                                    color: AppColor.blue,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.8),
                                                        spreadRadius: 0,
                                                        blurRadius: 3,
                                                        offset:
                                                            const Offset(0, 2),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      maxLines: 1,
                                                      product.price.toVND(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: _products.length,
                                crossAxisCount: 2,
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
