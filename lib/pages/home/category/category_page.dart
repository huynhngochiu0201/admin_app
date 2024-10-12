import 'package:flutter/material.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/components/cr_app_dialog.dart';
import 'package:admin_app/components/snack_bar/top_snack_bar.dart';
import 'package:admin_app/components/snack_bar/td_snack_bar.dart';
import 'package:admin_app/components/text_field/cr_text_field.dart';
import 'package:admin_app/constants/app_color.dart';
import 'package:admin_app/models/category_model.dart';
import 'package:admin_app/pages/home/category/widget/add_category.dart';
import 'package:admin_app/services/remote/category_service.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  late final CategoryService _categoryService;
  late Future<List<CategoryModel>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoryService = CategoryService();
    _categoriesFuture = _categoryService.fetchCategories();
  }

  Future<void> _refreshCategories() async {
    setState(() {
      _categoriesFuture = _categoryService.fetchCategories();
    });
  }

  Future<void> _deleteCategory(
      BuildContext context, CategoryModel category) async {
    try {
      await _categoryService.deleteCategory(category.id);
      _refreshCategories();
      showTopSnackBar(
        context,
        const TDSnackBar.success(message: 'Xóa danh mục thành công'),
      );
    } catch (error) {
      showTopSnackBar(
        context,
        TDSnackBar.error(message: 'Xóa danh mục thất bại: $error'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: CrElevatedButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddCategory()),
                );
                _refreshCategories();
              },
              text: 'Add Category',
              color: Colors.blue,
              borderColor: Colors.white,
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshCategories,
              child: FutureBuilder<List<CategoryModel>>(
                future: _categoriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No categories available.'));
                  }

                  final categories = snapshot.data!;
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 30.0),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return _buildCategoryItem(context, category);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, CategoryModel category) {
    return Container(
      height: 120.0,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            width: 100.0,
            height: 126.0,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(22.0),
              image: DecorationImage(
                image: NetworkImage(category.image ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            children: [
              IconButton(
                onPressed: () => _onEditPressed(context, category),
                icon: const Icon(Icons.edit, color: AppColor.red),
              ),
              const SizedBox(height: 20.0),
              IconButton(
                onPressed: () => _onDeletePressed(context, category),
                icon: const Icon(Icons.delete_outline_rounded,
                    color: AppColor.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onEditPressed(BuildContext context, CategoryModel category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _dialog(context, category);
      },
    );
  }

  void _onDeletePressed(BuildContext context, CategoryModel category) async {
    bool confirmed = await CrAppDialog.dialog(
      context,
      title: '😍',
      content: 'Bạn có muốn xoá danh mục này',
    );
    if (confirmed) {
      await _deleteCategory(context, category);
      _refreshCategories();
    }
  }

  Dialog _dialog(BuildContext context, CategoryModel category) {
    final nameController = TextEditingController(text: category.name);

    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Edit Category', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            CrTextField(
              controller: nameController,
              hintText: 'Name Category',
            ),
            const SizedBox(height: 20),
            CrElevatedButton(
              onPressed: () => _onSubmitEditCategory(
                  context, category, nameController.text.trim()),
              text: 'Submit',
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmitEditCategory(
      BuildContext context, CategoryModel category, String name) async {
    if (name.isNotEmpty) {
      try {
        await _categoryService.updateCategory(id: category.id, name: name);
        Navigator.of(context).pop();
        _refreshCategories();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating category: $e')),
        );
      }
    }
  }
}
