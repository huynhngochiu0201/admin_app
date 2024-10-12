import 'package:admin_app/components/app_bar/custom_app_bar.dart';
import 'package:admin_app/components/snack_bar/td_snack_bar.dart';
import 'package:admin_app/components/snack_bar/top_snack_bar.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/components/text_field/cr_text_field.dart';
import 'package:admin_app/components/text_field/cr_text_field_password.dart';
import 'package:admin_app/constants/app_color.dart';
import 'package:admin_app/models/user_model.dart';
import 'package:admin_app/utils/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> _onSubmit(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      showTopSnackBar(
        context,
        const TDSnackBar.error(message: 'Vui lòng nhập đủ nội dung'),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // Create user with Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      UserModel user = UserModel()
        ..id = userCredential.user?.uid // Use the created user ID
        ..name = nameController.text.trim()
        ..email = emailController.text.trim()
        ..role = 'staff'; // Assign role as 'staff'

      // Add the staff user to Firestore
      await _addUser(user);

      // Show success message
      showTopSnackBar(
        context,
        const TDSnackBar.success(
          message: 'Staff created successfully!',
        ),
      );

      // Navigate to another page or reset form after success
      Navigator.of(context).pop();
    } catch (error) {
      // Handle error from Firebase Authentication
      FirebaseAuthException authException = error as FirebaseAuthException;
      showTopSnackBar(
        context,
        TDSnackBar.error(
            message: authException.message ?? 'Error creating staff'),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _addUser(UserModel user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .set(user.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(title: 'Add Staff'),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            children: [
              const SizedBox(height: 40.0),
              CrTextField(
                controller: nameController,
                hintText: 'Full Name',
                prefixIcon: const Icon(Icons.person, color: AppColor.orange),
                textInputAction: TextInputAction.next,
                validator: Validator.required,
              ),
              const SizedBox(height: 20.0),
              CrTextField(
                controller: emailController,
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email, color: AppColor.orange),
                textInputAction: TextInputAction.next,
                validator: Validator.email,
              ),
              const SizedBox(height: 20.0),
              CrTextFieldPassword(
                controller: passwordController,
                hintText: 'Password',
                textInputAction: TextInputAction.next,
                validator: Validator.password,
              ),
              const SizedBox(height: 20.0),
              CrTextFieldPassword(
                controller: confirmPasswordController,
                onChanged: (_) => setState(() {}),
                hintText: 'Confirm Password',
                textInputAction: TextInputAction.done,
                validator: Validator.confirmPassword(
                  passwordController.text,
                ),
              ),
              const SizedBox(height: 56.0),
              CrElevatedButton(
                onPressed: () =>
                    _onSubmit(context), // Call the submit function here
                text: 'Submit',
                isDisable: isLoading, // Disable button when loading
              ),
              const SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }
}
