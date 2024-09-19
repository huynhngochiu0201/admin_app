// import 'package:admin_app/constants/app_color.dart';
// import 'package:flutter/material.dart';

// class Product extends StatelessWidget {
//   const Product({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Container(
//         height: 221,
//         //width: 120,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.8),
//               spreadRadius: 0,
//               blurRadius: 3,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),

//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0)
//                   .copyWith(top: 10),
//               child: Container(
//                 height: 100,
//                 width: size.width,
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(20))),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.asset(
//                     'assets/images/chungaotu.jpg',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10.0,
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: Column(
//                 children: [
//                   Align(
//                       alignment: Alignment.topLeft,
//                       child: Text('Name Product:')),
//                   Align(alignment: Alignment.topLeft, child: Text('Category:')),
//                   Align(alignment: Alignment.topLeft, child: Text('Quantity:')),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Container(
//                     height: 40.0,
//                     width: 50.0,
//                     decoration: BoxDecoration(
//                       color: AppColor.blue,
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(10),
//                         bottomRight: Radius.circular(10),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.8),
//                           spreadRadius: 0,
//                           blurRadius: 3,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: const Center(child: Text('\$'))),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
