import 'package:admin_app/resources/double_extension.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/models/product_model.dart';

class ItemProduct extends StatefulWidget {
  final ProductModel product;
  final Future<void> Function(ProductModel) onDelete;
  const ItemProduct({super.key, required this.product, required this.onDelete});
  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  bool isExpanded = false;
  Future<void> _deleteProduct() async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(false), // User pressed 'No'
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(true), // User pressed 'Yes'
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      try {
        await widget.onDelete(widget.product); // Call the delete callback
        Navigator.of(context).pop(); // Close the loading dialog
        Navigator.of(context).pop(); // Navigate back after deletion
      } catch (e) {
        Navigator.of(context).pop(); // Close the loading dialog
        print('Error deleting product: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.6),
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
                Text(widget.product.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                Text('${widget.product.price.toVND()} ',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                RichText(
                  text: TextSpan(
                    text: isExpanded || widget.product.description.length <= 200
                        ? widget.product.description
                        : widget.product.description.substring(0, 200),
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    children: [
                      if (!isExpanded &&
                          widget.product.description.length > 200)
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
