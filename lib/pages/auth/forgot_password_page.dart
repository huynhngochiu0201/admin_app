import 'package:flutter/material.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/components/text_field/cr_text_field.dart';
import 'package:admin_app/gen/assets.gen.dart';
//import 'package:admin_app/pages/auth/login_page.dart';
import 'package:admin_app/constants/app_color.dart';
//import 'package:admin_app/services/remote/body/auth_services.dart';
import 'package:admin_app/utils/validator.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;
  // final AuthService _authService = AuthService();

  // void _sendResetEmail() async {
  //   if (formKey.currentState!.validate()) {
  //     setState(() {
  //       isLoading = true;
  //     });

  //     String res =
  //         await _authService.sendPasswordReset(emailController.text.trim());

  //     setState(() {
  //       isLoading = false;
  //     });

  //     if (res == "success") {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Password reset email sent')),
  //       );

  //       await Future.delayed(const Duration(seconds: 3));
  //       Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(
  //           builder: (context) => const LoginPage(),
  //         ),
  //         (Route<dynamic> route) => false,
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(res)),
  //       );
  //       // Ở lại trang ForgotPasswordPage nếu gửi email không thành công
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                top: MediaQuery.of(context).padding.top + 20.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Forgot Password',
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 2.0),
                Text('Enter Your Email',
                    style: TextStyle(
                        color: AppColor.brown.withOpacity(0.8),
                        fontSize: 18.6)),
                const SizedBox(height: 38.0),
                Center(
                  child: Image.asset(Assets.images.autocarlogo.path,
                      width: 250.0, fit: BoxFit.cover),
                ),
                const SizedBox(height: 36.0),
                CrTextField(
                  controller: emailController,
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email, color: AppColor.orange),
                  validator: Validator.email,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 68.0),
                CrElevatedButton.outline(
                  onPressed: () {},
                  // isLoading ? null : _sendResetEmail,
                  text: 'Send',
                  isDisable: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
