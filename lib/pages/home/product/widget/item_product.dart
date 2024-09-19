// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:admin_app/models/product_model.dart';

// class ItemProduct extends StatefulWidget {
//   final ProductModel product;

//   const ItemProduct({super.key, required this.product});

//   @override
//   State<ItemProduct> createState() => _ItemProductState();
// }

// class _ItemProductState extends State<ItemProduct> {
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 40.0),
//                 child: Stack(
//                   children: [
//                     SizedBox(
//                       width: double.infinity,
//                       height: 411,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(40.0),
//                         child: Image.network(
//                           widget.product.image, // Display the product image
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 24,
//                       left: 10,
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Container(
//                           width: 40,
//                           height: 40,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(
//                             Icons.arrow_back,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20.0),
//               Text(widget.product.name, style: const TextStyle(fontSize: 24)),
//               Text('${widget.product.price} VND',
//                   style: const TextStyle(fontSize: 20)),
//               RichText(
//                 text: TextSpan(
//                   text: isExpanded || widget.product.description.length <= 200
//                       ? widget.product.description
//                       : widget.product.description.substring(0, 200),
//                   style: const TextStyle(color: Colors.black),
//                   children: [
//                     if (!isExpanded && widget.product.description.length > 200)
//                       TextSpan(
//                         text: '... Read more',
//                         style: const TextStyle(color: Colors.blue),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             setState(() {
//                               isExpanded = true;
//                             });
//                           },
//                       ),
//                     if (isExpanded && widget.product.description.length > 200)
//                       TextSpan(
//                         text: ' Show less',
//                         style: const TextStyle(color: Colors.blue),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             setState(() {
//                               isExpanded = false;
//                             });
//                           },
//                       ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   GestureDetector(
//                       onTap: () {}, child: const Icon(Icons.delete)),
//                   GestureDetector(onTap: () {}, child: const Icon(Icons.edit))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/models/product_model.dart';

class ItemProduct extends StatefulWidget {
  final ProductModel product;
  final Future<void> Function(ProductModel) onDelete; // Callback for delete

  const ItemProduct({super.key, required this.product, required this.onDelete});

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  bool isExpanded = false;

  Future<void> _deleteProduct() async {
    try {
      await widget.onDelete(widget.product); // Call the delete callback
      Navigator.of(context).pop(); // Navigate back after deletion
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 411,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Image.network(
                        widget.product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 24,
                    left: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Text(widget.product.name, style: const TextStyle(fontSize: 24)),
            Text('${widget.product.price} VND',
                style: const TextStyle(fontSize: 20)),
            RichText(
              text: TextSpan(
                text: isExpanded || widget.product.description.length <= 200
                    ? widget.product.description
                    : widget.product.description.substring(0, 200),
                style: const TextStyle(color: Colors.black),
                children: [
                  if (!isExpanded && widget.product.description.length > 200)
                    TextSpan(
                      text: '... Read more',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            isExpanded = true;
                          });
                        },
                    ),
                  if (isExpanded && widget.product.description.length > 200)
                    TextSpan(
                      text: ' Show less',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            isExpanded = false;
                          });
                        },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: _deleteProduct, child: const Icon(Icons.delete)),
                GestureDetector(onTap: () {}, child: const Icon(Icons.edit))
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
