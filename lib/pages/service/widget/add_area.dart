import 'package:admin_app/components/app_bar/custom_app_bar.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/components/snack_bar/td_snack_bar.dart';
import 'package:admin_app/components/snack_bar/top_snack_bar.dart';
import 'package:admin_app/components/text_field/cr_text_field.dart';
import 'package:admin_app/services/remote/area_service.dart';
import 'package:flutter/material.dart';

class AddArea extends StatefulWidget {
  const AddArea({super.key});

  @override
  State<AddArea> createState() => _AddAreaState();
}

class _AddAreaState extends State<AddArea> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  bool _isLoading = false;

  final AreaService _areaService = AreaService();

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();

    super.dispose();
  }

  Future<void> _submitForm() async {
    if (nameController.text.isEmpty || priceController.text.isEmpty) {
      showTopSnackBar(
        context,
        const TDSnackBar.error(
            message: 'Please enter all required information'),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String areaName = nameController.text;
      double price = double.parse(priceController.text);

      await _areaService.addArea(
        name: areaName,
        price: price,
      );
      showTopSnackBar(
          context, const TDSnackBar.success(message: 'Area added successfully'));
      Navigator.of(context).pop(); // Return to previous screen after successful addition
    } catch (e) {
      showTopSnackBar(context, TDSnackBar.error(message: 'Error:$e'));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Area'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            CrTextField(
              controller: nameController,
              hintText: 'Enter area name',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Area name is required';
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
                  return 'Please enter a valid number';
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
