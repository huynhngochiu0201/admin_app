// import 'package:admin_app/components/button/cr_elevated_button.dart';
// import 'package:admin_app/constants/app_color.dart';
// import 'package:admin_app/pages/home/product/widget/add_product.dart';
// import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
// import 'package:flutter/material.dart';

// // import 'package:admin_app/pages/home/product/widget/product.dart';

// class ProductPage extends StatefulWidget {
//   const ProductPage({super.key});

//   @override
//   State<ProductPage> createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Padding(
//         padding:
//             const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 20.0),
//         child: Column(
//           children: [
//             CrElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => AddProduct()),
//                 );
//               },
//               text: 'Add Product',
//               color: Colors.blue,
//               borderColor: Colors.white,
//             ),
//             const SizedBox(height: 20.0),
//             Expanded(
//               child: DynamicHeightGridView(
//                   builder: (context, index) {
//                     return Container(
//                       height: 221,
//                       //width: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.8),
//                             spreadRadius: 0,
//                             blurRadius: 3,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),

//                       child: Column(
//                         children: [
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 10.0)
//                                     .copyWith(top: 10),
//                             child: Container(
//                               height: 100,
//                               width: size.width,
//                               decoration: const BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20))),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Image.asset(
//                                   'assets/images/chungaotu.jpg',
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 10.0,
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 10),
//                             child: Column(
//                               children: [
//                                 Align(
//                                     alignment: Alignment.topLeft,
//                                     child: Text('Name Product:')),
//                                 Align(
//                                     alignment: Alignment.topLeft,
//                                     child: Text('Category:')),
//                                 Align(
//                                     alignment: Alignment.topLeft,
//                                     child: Text('Quantity:')),
//                               ],
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Container(
//                                   height: 40.0,
//                                   width: 50.0,
//                                   decoration: BoxDecoration(
//                                     color: AppColor.blue,
//                                     borderRadius: const BorderRadius.only(
//                                       topLeft: Radius.circular(10),
//                                       bottomRight: Radius.circular(10),
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.8),
//                                         spreadRadius: 0,
//                                         blurRadius: 3,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: const Center(child: Text('price'))),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   itemCount: 10,
//                   crossAxisCount: 2),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

//

import 'package:admin_app/models/product_model.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/constants/app_color.dart';
import 'package:admin_app/pages/home/product/widget/add_product.dart';
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

  // Method to fetch products from ProductService
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
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
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 221,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.8),
                                          spreadRadius: 0,
                                          blurRadius: 3,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                                  horizontal: 10.0)
                                              .copyWith(top: 10),
                                          child: Container(
                                            height: 100,
                                            width: size.width,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
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
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(product.name),
                                              Text(product.categoryId),
                                              Text(
                                                  'Quantity: ${product.quantity}'),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 40.0,
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                color: AppColor.blue,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.8),
                                                    spreadRadius: 0,
                                                    blurRadius: 3,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${product.price} VND',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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
    );
  }
}
