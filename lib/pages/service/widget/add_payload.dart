import 'package:admin_app/components/app_bar/custom_app_bar.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/components/snack_bar/td_snack_bar.dart';
import 'package:admin_app/components/snack_bar/top_snack_bar.dart';
import 'package:admin_app/components/text_field/cr_text_field.dart';
import 'package:admin_app/services/remote/payload_service.dart';
import 'package:flutter/material.dart';

class AddPayload extends StatefulWidget {
  const AddPayload({super.key});

  @override
  State<AddPayload> createState() => _AddPayloadState();
}

class _AddPayloadState extends State<AddPayload> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  bool _isLoading = false;

  final PayloadService _payloadService = PayloadService();

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (nameController.text.trim().isEmpty) {
      showTopSnackBar(
        context,
        const TDSnackBar.error(message: 'Service name is required'),
      );
      return;
    }

    final price = double.tryParse(priceController.text);
    if (price == null) {
      showTopSnackBar(
        context,
        const TDSnackBar.error(message: 'Please enter a valid price'),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _payloadService.addPayload(
          name: nameController.text.trim(), price: price);
      showTopSnackBar(context,
          const TDSnackBar.success(message: 'Service added successfully'));
      Navigator.of(context).pop(); // Return to previous screen
    } catch (e) {
      showTopSnackBar(context, TDSnackBar.error(message: 'Error: $e'));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Service'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            CrTextField(
              controller: nameController,
              hintText: 'Enter service name',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Service name is required';
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
