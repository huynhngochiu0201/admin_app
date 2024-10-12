import 'package:admin_app/components/snack_bar/td_snack_bar.dart';
import 'package:admin_app/components/snack_bar/top_snack_bar.dart';
import 'package:admin_app/models/update_product_model.dart';
import 'package:admin_app/models/category_model.dart';
import 'package:admin_app/services/remote/category_service.dart';
import 'package:admin_app/services/remote/product_service.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/components/text_field/cr_text_field.dart';

class EditProductDialog extends StatefulWidget {
  final String? productId; // Add productId to update
  final String? initialName;
  final double? initialPrice;
  final String? initialDescription;
  final String? initialCategory;
  final int? initialQuantity;

  const EditProductDialog({
    super.key,
    required this.productId,
    this.initialName,
    this.initialPrice,
    this.initialDescription,
    this.initialCategory,
    this.initialQuantity,
  });

  @override
  _EditProductDialogState createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final CategoryService categoryService = CategoryService();

  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName ?? '';
    _priceController.text = widget.initialPrice?.toString() ?? '';
    _descriptionController.text = widget.initialDescription ?? '';
    _selectedCategory = null; // Initially set to null, we'll set this later.
    _quantityController.text = widget.initialQuantity?.toString() ?? '';
  }

  Future<void> _submit() async {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final product = UpdateProductModel(
      productId: widget.productId,
      productName: _nameController.text,
      price: double.tryParse(_priceController.text),
      description: _descriptionController.text,
      cateId: _selectedCategory, // Use the id field of CategoryModel
      quantity: int.tryParse(_quantityController.text),
    );

    try {
      await ProductService().updateProduct(product);
      Navigator.pop(context, true); // Close dialog and return true
    } catch (e) {
      showTopSnackBar(context, TDSnackBar.error(message: 'Error: $e'));
    }
  }

  Widget _buildCategoryDropdown(List<CategoryModel> categories) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select Category',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      isExpanded: true,
      value: _selectedCategory,
      onChanged: (newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
      items: categories.map((category) {
        return DropdownMenuItem<String>(
          value: category.id,
          child: Text(category.name ?? 'ngu'),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select a category';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CrTextField(
            controller: _nameController,
            hintText: 'Enter product name',
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CrTextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  hintText: 'Quantity',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CrTextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  hintText: 'Price',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Category',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          const SizedBox(height: 5.0),
          FutureBuilder<List<CategoryModel>>(
            future: categoryService.fetchCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Text('Error loading categories');
              } else {
                return _buildCategoryDropdown(snapshot.data!);
              }
            },
          ),
          const SizedBox(height: 10),
          CrTextField(
            maxLines: 4,
            controller: _descriptionController,
            hintText: 'Enter product description',
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CrElevatedButton(
                text: 'Cancel',
                onPressed: () {
                  Navigator.pop(context); // Close dialog without changes
                },
              ),
              CrElevatedButton(
                text: 'Submit',
                onPressed: _submit, // Call the submit method
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}
