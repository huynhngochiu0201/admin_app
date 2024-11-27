import 'package:admin_app/components/app_bar/custom_app_bar.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/components/snack_bar/td_snack_bar.dart';
import 'package:admin_app/components/snack_bar/top_snack_bar.dart';
import 'package:admin_app/components/text_field/cr_text_field.dart';
import 'package:admin_app/services/remote/wheel_size_service.dart';
import 'package:flutter/material.dart';

class AddWheelSize extends StatefulWidget {
  const AddWheelSize({super.key});

  @override
  State<AddWheelSize> createState() => _AddWheelSizeState();
}

class _AddWheelSizeState extends State<AddWheelSize> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  bool _isLoading = false;

  final WheelSizeService _wheelSizeService = WheelSizeService();

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();

    super.dispose();
  }

  Future<void> _submitForm() async {
    final name = nameController.text.trim();
    final priceText = priceController.text.trim();

    if (name.isEmpty) {
      showTopSnackBar(
        context,
        const TDSnackBar.error(message: 'Please enter wheel size'),
      );
      return;
    }

    if (priceText.isEmpty) {
      showTopSnackBar(
        context,
        const TDSnackBar.error(message: 'Please enter price'),
      );
      return;
    }

    final price = double.tryParse(priceText);
    if (price == null) {
      showTopSnackBar(
        context,
        const TDSnackBar.error(message: 'Please enter valid price'),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _wheelSizeService.addWheelSize(name: name, price: price);
      showTopSnackBar(context,
          const TDSnackBar.success(message: 'Wheel size added successfully'));
      Navigator.of(context).pop();
    } catch (e) {
      showTopSnackBar(context, TDSnackBar.error(message: 'Error: $e'));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Wheel Size'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            CrTextField(
              controller: nameController,
              hintText: 'Enter wheel size',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Wheel size is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CrTextField(
              controller: priceController,
              hintText: 'Enter price',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Price is required';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter valid price';
                }
                return null;
              },
            ),
            const SizedBox(height: 60),
            _isLoading
                ? const CircularProgressIndicator()
                : CrElevatedButton(text: 'Submit', onPressed: _submitForm),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
