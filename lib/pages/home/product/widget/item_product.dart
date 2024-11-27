import 'package:admin_app/pages/home/product/widget/edit_product.dart';
import 'package:admin_app/resources/double_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/models/product_model.dart';

import '../../../../components/cr_app_dialog.dart';
import '../../../../components/snack_bar/td_snack_bar.dart';
import '../../../../components/snack_bar/top_snack_bar.dart';

class ItemProduct extends StatefulWidget {
  final ProductModel product;
  final Future<void> Function(ProductModel) onDelete;

  const ItemProduct({super.key, required this.product, required this.onDelete});

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  bool isExpanded = false;

  Future<void> _deleteProduct(BuildContext context) async {
    bool confirmed = await CrAppDialog.dialog(
      context,
      title: '😍',
      content: 'Bạn có muốn xóa sản phẩm này không?',
    );

    if (!confirmed) return;

    try {
      await widget.onDelete(widget.product);
      showTopSnackBar(
        context,
        const TDSnackBar.success(message: 'Xóa sản phẩm thành công'),
      );
      Navigator.pop(context, true); // Pop with a result of true
    } catch (error) {
      showTopSnackBar(
        context,
        TDSnackBar.error(message: 'Xóa sản phẩm thất bại: $error'),
      );
    }
  }

  Future<void> _editProduct(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Product'),
          content: EditProductDialog(
            productId: widget.product.id,
            initialName: widget.product.name,
            initialPrice: widget.product.price,
            initialDescription: widget.product.description,
            // initialCategory: widget.product.categoryId,
            initialQuantity: widget.product.quantity,
          ),
        );
      },
    );

    if (result == true) {
      // Handle result if needed
      Navigator.pop(context, true); // Pop with a result of true
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
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                widget.product.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Quantity: ${widget.product.quantity.toString()}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Price ${widget.product.price.toVND()}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: isExpanded || widget.product.description.length <= 200
                      ? widget.product.description
                      : widget.product.description.substring(0, 200),
                  style: const TextStyle(color: Colors.black, fontSize: 20),
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
                    onTap: () => _deleteProduct(context),
                    child: const Icon(Icons.delete),
                  ),
                  GestureDetector(
                    onTap: () => _editProduct(context),
                    child: const Icon(Icons.edit),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
