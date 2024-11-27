import 'dart:typed_data';
import 'package:admin_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_app/services/local/define_collection.dart';
import 'package:admin_app/services/remote/product_service.dart';
import 'package:admin_app/components/app_bar/custom_app_bar.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/components/text_field/cr_text_field.dart';
import 'package:admin_app/constants/app_color.dart';
import 'package:admin_app/models/add_product_model.dart';
import '../../../../components/snack_bar/td_snack_bar.dart';
import '../../../../components/snack_bar/top_snack_bar.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Uint8List? _selectedImage;
  CategoryModel? _selectedCategory;
  bool _isLoading = false;
  bool _isCategoryLoading = true;

  List<CategoryModel> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(AppDefineCollection.APP_CATEGORY)
          .get();

      setState(() {
        _categories = snapshot.docs
            .map((doc) => CategoryModel.fromJson(doc.data()))
            .toList();
        _isCategoryLoading = false;
      });
    } catch (e) {
      setState(() {
        _isCategoryLoading = false;
      });
      showTopSnackBar(
          context, TDSnackBar.error(message: 'Failed to load categories: $e'));
    }
  }

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 80,
    );

    if (image != null) {
      final imageBytes = await image.readAsBytes();
      setState(() {
        _selectedImage = imageBytes;
      });
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCategory == null) {
      showTopSnackBar(
          context, const TDSnackBar.error(message: 'Please select a category'));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final addProductModel = AddProductModel(
        cateId:
            _selectedCategory!.id, // Assuming you have an id in CategoryModel
        productName: _nameController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        quantity: int.parse(_quantityController.text.trim()),
        description: _descriptionController.text.trim(),
        image: _selectedImage,
      );

      await ProductService().addNewProduct(addProductModel);

      showTopSnackBar(context,
          const TDSnackBar.success(message: 'Product added successfully'));
      // Clear the form and reset state
      _formKey.currentState!.reset();
      _resetState();
      Navigator.pop(context);
    } catch (e) {
      showTopSnackBar(
          context, TDSnackBar.error(message: 'Failed to add product: $e'));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _resetState() {
    setState(() {
      _selectedImage = null;
      _selectedCategory = null;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(title: 'Add Product'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildImagePicker(),
                  const SizedBox(height: 20.0),
                  _buildTextField(
                    controller: _nameController,
                    label: 'Product Name',
                    hintText: 'Enter product name',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Product name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _priceController,
                          label: 'Price',
                          hintText: 'Enter price',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Price is required';
                            }
                            if (double.tryParse(value.trim()) == null) {
                              return 'Enter a valid number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: _buildTextField(
                          controller: _quantityController,
                          label: 'Quantity',
                          hintText: 'Enter quantity',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Quantity is required';
                            }
                            if (int.tryParse(value.trim()) == null) {
                              return 'Enter a valid integer';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Column(
                    children: [
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
                          : _buildCategoryDropdown(),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  _buildDescriptionField(),
                  const SizedBox(height: 20.0),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CrElevatedButton(
                              text: 'Cancel',
                              onPressed: () {
                                _formKey.currentState!.reset();
                                _resetState();
                              },
                            ),
                            CrElevatedButton(
                              text: 'Submit',
                              onPressed: _submit,
                            ),
                          ],
                        ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
        const SizedBox(height: 5.0),
        CrTextField(
          controller: controller,
          keyboardType: keyboardType,
          hintText: hintText,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<CategoryModel>(
      decoration: InputDecoration(
        labelText: 'Select Category',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: AppColor.bgaddimages,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down),
      hint: const Text('Select Category'),
      value: _selectedCategory,
      onChanged: (CategoryModel? newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
      validator: (CategoryModel? value) {
        if (value == null) {
          return 'Please select a category';
        }
        return null;
      },
      items: _categories
          .map<DropdownMenuItem<CategoryModel>>((CategoryModel category) {
        return DropdownMenuItem<CategoryModel>(
          value: category,
          child: Text(category.name
              .toString()), // or category.name if you have a name field
        );
      }).toList(),
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Description',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        const SizedBox(height: 5.0),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 158, 158, 158).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _descriptionController,
              maxLines: 10,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter product description...',
              ),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Description is required';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            if (_selectedImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.memory(
                  _selectedImage!,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                ),
              )
            else
              Center(
                child: SvgPicture.asset(
                  'assets/icons/add-image-photo-icon.svg',
                  width: 50,
                  height: 50,
                ),
              ),
            if (_selectedImage != null)
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImage = null;
                    });
                  },
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
