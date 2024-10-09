import 'package:admin_app/models/update_product_model.dart';
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
  final List<String> _categories = []; // List of categories
  String? _selectedCategory;
  bool _isCategoryLoading = true; // Set to true to show loading initially

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the passed data
    _nameController.text = widget.initialName ?? '';
    _priceController.text = widget.initialPrice?.toString() ?? '';
    _descriptionController.text = widget.initialDescription ?? '';
    _selectedCategory = widget.initialCategory;
    _quantityController.text = widget.initialQuantity?.toString() ?? '';

    _loadCategories(); // Load categories when initializing
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isCategoryLoading = true; // Show loading indicator
    });

    try {
      // Fetch categories from the ProductService
      _categories.addAll(await ProductService().fetchCategories());
    } catch (e) {
      // Handle any errors that occur during fetching
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading categories: $e')),
      );
    } finally {
      setState(() {
        _isCategoryLoading = false; // Hide loading indicator
      });
    }
  }

  Future<void> _submit() async {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _selectedCategory == null) {
      // Handle validation errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    // Create an instance of UpdateProductModel
    final product = UpdateProductModel(
      productId: widget.productId,
      productName: _nameController.text,
      price: double.tryParse(_priceController.text),
      description: _descriptionController.text,
      cateId: _selectedCategory, // Make sure cateId is correctly set
      quantity: int.tryParse(_quantityController.text), // Convert to int
      // Add other fields as necessary, e.g., image if you want to update it
    );

    try {
      final productService = ProductService();
      await productService.updateProduct(product);
      Navigator.pop(context); // Close dialog after submission
    } catch (e) {
      // Handle any errors that occurred during submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CrTextField(
            controller: _nameController,
            hintText: 'Enter product name',
          ),
          const SizedBox(height: 10),
          CrTextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            hintText: 'Enter Quantity',
          ),
          const SizedBox(height: 10),
          CrTextField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            hintText: 'Enter price',
          ),
          const SizedBox(height: 10),
          CrTextField(
            maxLines: 4,
            controller: _descriptionController,
            hintText: 'Enter product description',
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
          _isCategoryLoading
              ? const CircularProgressIndicator()
              : DropdownButtonFormField<String>(
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
                  items: _categories.map<DropdownMenuItem<String>>(
                    (String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    },
                  ).toList(),
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

// import 'package:admin_app/models/update_product_model.dart';
// import 'package:admin_app/services/remote/product_service.dart';
// import 'package:flutter/material.dart';
// import 'package:admin_app/components/button/cr_elevated_button.dart';
// import 'package:admin_app/components/text_field/cr_text_field.dart';

// class EditProductDialog extends StatefulWidget {
//   final String? productId; // Add productId to update
//   final String? initialName;
//   final double? initialPrice;
//   final String? initialDescription;
//   final String? initialCategory;
//   final int? initialQuantity;
//   final VoidCallback onProductUpdated; // Callback for updating state

//   const EditProductDialog({
//     super.key,
//     required this.productId,
//     this.initialName,
//     this.initialPrice,
//     this.initialDescription,
//     this.initialCategory,
//     this.initialQuantity,
//     required this.onProductUpdated, // Add this line
//   });

//   @override
//   _EditProductDialogState createState() => _EditProductDialogState();
// }

// class _EditProductDialogState extends State<EditProductDialog> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final List<String> _categories = []; // List of categories
//   String? _selectedCategory;
//   bool _isCategoryLoading = true; // Set to true to show loading initially

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the controllers with the passed data
//     _nameController.text = widget.initialName ?? '';
//     _priceController.text = widget.initialPrice?.toString() ?? '';
//     _descriptionController.text = widget.initialDescription ?? '';
//     _selectedCategory = widget.initialCategory;
//     _quantityController.text = widget.initialQuantity?.toString() ?? '';

//     _loadCategories(); // Load categories when initializing
//   }

//   Future<void> _loadCategories() async {
//     setState(() {
//       _isCategoryLoading = true; // Show loading indicator
//     });

//     try {
//       // Fetch categories from the ProductService
//       _categories.addAll(await ProductService().fetchCategories());
//     } catch (e) {
//       // Handle any errors that occur during fetching
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error loading categories: $e')),
//       );
//     } finally {
//       setState(() {
//         _isCategoryLoading = false; // Hide loading indicator
//       });
//     }
//   }

//   Future<void> _submit() async {
//     if (_nameController.text.isEmpty ||
//         _priceController.text.isEmpty ||
//         _quantityController.text.isEmpty ||
//         _selectedCategory == null) {
//       // Handle validation errors
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all fields')),
//       );
//       return;
//     }

//     // Create an instance of UpdateProductModel
//     final product = UpdateProductModel(
//       productId: widget.productId,
//       productName: _nameController.text,
//       price: double.tryParse(_priceController.text),
//       description: _descriptionController.text,
//       cateId: _selectedCategory, // Make sure cateId is correctly set
//       quantity: int.tryParse(_quantityController.text), // Convert to int
//     );

//     try {
//       final productService = ProductService();
//       await productService.updateProduct(product);
//       widget.onProductUpdated(); // Call the callback to update parent state
//       Navigator.pop(context); // Close dialog after submission
//     } catch (e) {
//       // Handle any errors that occurred during submission
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 400,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           CrTextField(
//             controller: _nameController,
//             hintText: 'Enter product name',
//           ),
//           const SizedBox(height: 10),
//           CrTextField(
//             controller: _quantityController,
//             keyboardType: TextInputType.number,
//             hintText: 'Enter Quantity',
//           ),
//           const SizedBox(height: 10),
//           CrTextField(
//             controller: _priceController,
//             keyboardType: TextInputType.number,
//             hintText: 'Enter price',
//           ),
//           const SizedBox(height: 10),
//           CrTextField(
//             maxLines: 4,
//             controller: _descriptionController,
//             hintText: 'Enter product description',
//           ),
//           const SizedBox(height: 10),
//           const Align(
//             alignment: Alignment.topLeft,
//             child: Text(
//               'Category',
//               style: TextStyle(fontSize: 18.0),
//             ),
//           ),
//           const SizedBox(height: 5.0),
//           _isCategoryLoading
//               ? const CircularProgressIndicator()
//               : DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     labelText: 'Select Category',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                   isExpanded: true,
//                   value: _selectedCategory,
//                   onChanged: (newValue) {
//                     setState(() {
//                       _selectedCategory = newValue;
//                     });
//                   },
//                   items: _categories.map<DropdownMenuItem<String>>(
//                     (String category) {
//                       return DropdownMenuItem<String>(
//                         value: category,
//                         child: Text(category),
//                       );
//                     },
//                   ).toList(),
//                 ),
//           const SizedBox(height: 20.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               CrElevatedButton(
//                 text: 'Cancel',
//                 onPressed: () {
//                   Navigator.pop(context); // Close dialog without changes
//                 },
//               ),
//               CrElevatedButton(
//                 text: 'Submit',
//                 onPressed: _submit, // Call the submit method
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _priceController.dispose();
//     _descriptionController.dispose();
//     _quantityController.dispose();
//     super.dispose();
//   }
// }
