import 'dart:typed_data';
import 'package:admin_app/components/app_bar/custom_app_bar.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/components/snack_bar/td_snack_bar.dart';
import 'package:admin_app/components/snack_bar/top_snack_bar.dart';
import 'package:admin_app/components/text_field/cr_text_field.dart';
import 'package:admin_app/services/remote/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Uint8List? _selectedImage;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  final ServiceService _serviceService = ServiceService();

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose(); // Dispose descriptionController
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 80,
    );
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes();
      setState(() {
        _selectedImage = imageBytes;
      });
    }
  }

  Future<void> _submitForm() async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      // Show validation error
      showTopSnackBar(
        context,
        const TDSnackBar.error(message: 'Vui lòng nhập đầy đủ thông tin'),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String serviceName = nameController.text;
      String serviceDescription = descriptionController.text;
      double servicePrice = double.parse(priceController.text);

      // Call the service to add the data
      await _serviceService.addService(
        name: serviceName,
        description: serviceDescription,
        price: servicePrice,
        imageFile: _selectedImage,
      );
      showTopSnackBar(
          context, const TDSnackBar.success(message: 'add service done'));
      Navigator.of(context)
          .pop(); // Quay lại trang trước sau khi thêm thành công
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
      appBar: const CustomAppBar(title: 'Add Service'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey, width: 2),
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
              ],
            ),
            const SizedBox(height: 20.0),
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
            const SizedBox(height: 20.0),
            CrTextField(
              controller: priceController,
              hintText: 'Enter price',
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
            const SizedBox(height: 20.0),
            Column(
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
                        color: const Color.fromARGB(255, 158, 158, 158)
                            .withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter service description...',
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
