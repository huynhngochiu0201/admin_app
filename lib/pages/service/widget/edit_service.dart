import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/components/text_field/cr_text_field.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/models/service_model.dart';
import 'package:admin_app/services/remote/service.dart';

class EditServiceDialog extends StatefulWidget {
  final ServiceModel service;
  final VoidCallback onUpdate;

  const EditServiceDialog(
      {super.key, required this.service, required this.onUpdate});

  @override
  _EditServiceDialogState createState() => _EditServiceDialogState();
}

class _EditServiceDialogState extends State<EditServiceDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.service.name ?? '';
    _priceController.text = widget.service.price.toString();
    _descriptionController.text = widget.service.description ?? '';
  }

  Future<void> _updateService() async {
    final serviceService = ServiceService();
    try {
      await serviceService.updateServiceById(
        widget.service.id,
        _nameController.text,
        double.tryParse(_priceController.text) ?? 0,
        _descriptionController.text,
      );
      widget.onUpdate(); // Call the update callback
    } catch (e) {
      print('Error updating service: $e');
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
            hintText: 'Name',
            labelText: 'Name',
          ),
          const SizedBox(height: 20.0),
          CrTextField(
            controller: _priceController,
            hintText: 'Price',
            labelText: 'Price',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20.0),
          CrTextField(
            controller: _descriptionController,
            hintText: 'Description',
            labelText: 'Description',
            maxLines: 6,
          ),
          const SizedBox(height: 20),
          CrElevatedButton(
            onPressed: () {
              _updateService();
              Navigator.of(context).pop(); // Close the dialog after update
            },
            text: 'Subims',
          ),
        ],
      ),
    );
  }
}
