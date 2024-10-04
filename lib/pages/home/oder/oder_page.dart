import 'package:admin_app/constants/app_color.dart';
import 'package:admin_app/models/order_model.dart';
import 'package:admin_app/services/remote/order_service.dart';
import 'package:flutter/material.dart';

class OderPage extends StatefulWidget {
  const OderPage({super.key});

  @override
  OderPageState createState() => OderPageState();
}

class OderPageState extends State<OderPage> {
  final OrderService _orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<OrderModel>>(
              stream: _orderService.getAllOrders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error occurred'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No orders available'),
                  );
                } else {
                  List<OrderModel> orders = snapshot.data!;
                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      OrderModel order = orders[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 20.0,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20.0)
                                        .copyWith(top: 5),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Date: ${order.createdAt}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Total: \$${order.totalPrice}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Address: ${order.address}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Phone: ${order.phoneNumber}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Email: ${order.email}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: order.cartData.length,
                                itemBuilder: (context, itemIndex) {
                                  var cartItem = order.cartData[itemIndex];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10.0),
                                          width: 100.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: AppColor.white,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  cartItem.productImage),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cartItem.productName,
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 8.0),
                                                Text(
                                                  '\$${cartItem.productPrice}',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                                const SizedBox(height: 8.0),
                                                Text(
                                                  'Quantity: ${cartItem.quantity}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    iconSize: 30,
                                    onPressed: () {},
                                    icon: const Icon(Icons.cancel,
                                        color: AppColor.red),
                                  ),
                                  IconButton(
                                    iconSize: 30,
                                    onPressed: () {},
                                    icon: const Icon(Icons.done,
                                        color: AppColor.red),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:admin_app/constants/app_color.dart';
// import 'package:admin_app/models/order_model.dart';
// import 'package:admin_app/services/remote/order_service.dart';
// import 'package:flutter/material.dart';

// class OderPage extends StatefulWidget {
//   const OderPage({super.key});

//   @override
//   OderPageState createState() => OderPageState();
// }

// class OderPageState extends State<OderPage> {
//   final OrderService _orderService = OrderService();

//   // Function to delete an order
//   Future<void> _deleteOrder(String orderId) async {
//     await _orderService.deleteOrder(orderId);
//   }

//   // Function to update the order status to 'done'
//   Future<void> _markOrderAsDone(String orderId) async {
//     await _orderService.updateOrderStatus(
//         orderId, 'done'); // Assuming 'done' is the status you want to set
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<List<OrderModel>>(
//               stream: _orderService.getAllOrders(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (snapshot.hasError) {
//                   return const Center(
//                     child: Text('An error occurred'),
//                   );
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return const Center(
//                     child: Text('No orders available'),
//                   );
//                 } else {
//                   List<OrderModel> orders = snapshot.data!;
//                   return ListView.builder(
//                     itemCount: orders.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       OrderModel order = orders[index];
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 20.0),
//                         child: Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(35.0),
//                             boxShadow: const [
//                               BoxShadow(
//                                 color: Colors.black26,
//                                 offset: Offset(0, 2),
//                                 blurRadius: 20.0,
//                               )
//                             ],
//                           ),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 20.0)
//                                         .copyWith(top: 5),
//                                 child: Column(
//                                   children: [
//                                     Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Text(
//                                         'Date: ${order.createdAt}',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16.0,
//                                         ),
//                                       ),
//                                     ),
//                                     Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Text(
//                                         'Total: \$${order.totalPrice}',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16.0,
//                                         ),
//                                       ),
//                                     ),
//                                     Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Text(
//                                         'Address: ${order.address}',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16.0,
//                                         ),
//                                       ),
//                                     ),
//                                     Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Text(
//                                         'Phone: ${order.phoneNumber}',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16.0,
//                                         ),
//                                       ),
//                                     ),
//                                     Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Text(
//                                         'Email: ${order.email}',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16.0,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const Divider(),
//                               ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: order.cartData.length,
//                                 itemBuilder: (context, itemIndex) {
//                                   var cartItem = order.cartData[itemIndex];
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 10.0, horizontal: 10.0),
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                           margin: const EdgeInsets.all(10.0),
//                                           width: 100.0,
//                                           height: 100.0,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(20.0),
//                                             color: AppColor.white,
//                                             image: DecorationImage(
//                                               image: NetworkImage(
//                                                   cartItem.productImage),
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 10.0),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   cartItem.productName,
//                                                   maxLines: 2,
//                                                   style: const TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18.0,
//                                                   ),
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                 ),
//                                                 const SizedBox(height: 8.0),
//                                                 Text(
//                                                   '\$${cartItem.productPrice}',
//                                                   style: const TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 16.0,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(height: 8.0),
//                                                 Text(
//                                                   'Quantity: ${cartItem.quantity}',
//                                                   style: const TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 16.0,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                               const Divider(),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   IconButton(
//                                     iconSize: 30,
//                                     onPressed: () async {
//                                       await _deleteOrder(order.id);
//                                       setState(() {}); // Refresh the state
//                                     },
//                                     icon: const Icon(Icons.cancel,
//                                         color: AppColor.red),
//                                   ),
//                                   IconButton(
//                                     iconSize: 30,
//                                     onPressed: () async {
//                                       await _markOrderAsDone(order.id);
//                                       setState(() {}); // Refresh the state
//                                     },
//                                     icon: const Icon(Icons.done,
//                                         color: AppColor
//                                             .green), // Change color for 'done'
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
