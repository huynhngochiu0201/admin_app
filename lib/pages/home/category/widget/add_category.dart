import 'dart:typed_data';
import 'package:admin_app/components/app_bar/custom_app_bar.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/components/text_field/cr_text_field.dart';
import 'package:admin_app/services/remote/category_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../components/snack_bar/td_snack_bar.dart';
import '../../../../components/snack_bar/top_snack_bar.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController nameController = TextEditingController();
  final CategoryService _categoryService = CategoryService();
  Uint8List? _selectedImage;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  // Hàm chọn ảnh
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource
          .gallery, // Có thể thay đổi thành ImageSource.camera để chụp ảnh
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 80, // Giảm chất lượng để tối ưu kích thước
    );

    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes();
      setState(() {
        _selectedImage = imageBytes;
      });
    }
  }

  // Hàm gửi dữ liệu danh mục
  Future<void> _submitCategory() async {
    final String name = nameController.text.trim();
    if (name.isEmpty) {
      showTopSnackBar(
        context,
        const TDSnackBar.error(message: 'Vui lòng nhập tên danh mục'),
      );

      return;
    }

    if (_selectedImage == null) {
      showTopSnackBar(
        context,
        const TDSnackBar.error(message: 'Vui lòng chọn ảnh'),
      );

      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _categoryService.addNewCategory(
        name: name,
        imageBytes: _selectedImage!,
      );

      showTopSnackBar(
        context,
        const TDSnackBar.success(message: 'Thêm danh mục thành công'),
      );

      Navigator.of(context)
          .pop(); // Quay lại trang trước sau khi thêm thành công
    } catch (e) {
      showTopSnackBar(context, TDSnackBar.error(message: ' Lỗi: $e'));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Hàm xây dựng giao diện
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Thêm Danh Mục'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            GestureDetector(
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
                    _selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.memory(
                              _selectedImage!,
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            ),
                          )
                        : Center(
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
            ),
            const SizedBox(height: 20.0),
            CrTextField(
              controller: nameController,
              hintText: 'Thêm Danh Mục',
            ),
            const Spacer(),
            _isLoading
                ? const CircularProgressIndicator()
                : CrElevatedButton(
                    text: 'Xác nhận',
                    onPressed: _submitCategory,
                  ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
