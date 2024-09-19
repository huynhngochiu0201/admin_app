// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:admin_app/components/button/cr_elevated_button.dart';
// import 'package:admin_app/components/text_field/cr_text_field.dart';
// import 'package:admin_app/components/text_field/cr_text_field_password.dart';
// import 'package:admin_app/gen/assets.gen.dart';
// import 'package:admin_app/pages/auth/login_page.dart';
// import 'package:admin_app/constants/app_color.dart';
// import 'package:admin_app/utils/validator.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();
//   FocusNode nameFocus = FocusNode();
//   bool isChecked = false;
//   final formKey = GlobalKey<FormState>();
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: formKey,
//         child: ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
//               top: MediaQuery.of(context).padding.top + 38.0, bottom: 16.0),
//           children: [
//             const Text(
//               'Register',
//               style: TextStyle(color: AppColor.black, fontSize: 26.0),
//               textAlign: TextAlign.center,
//             ),
//             Center(
//               child: Image.asset(Assets.images.autocarlogo.path,
//                   width: 250.0, fit: BoxFit.cover),
//             ),
//             const SizedBox(height: 25.0),
//             CrTextField(
//               controller: nameController,
//               focusNode: nameFocus,
//               hintText: 'Full Name',
//               prefixIcon: const Icon(Icons.person, color: AppColor.orange),
//               textInputAction: TextInputAction.next,
//               validator: Validator.required,
//             ),
//             const SizedBox(height: 25.0),
//             CrTextField(
//               controller: emailController,
//               hintText: 'Email',
//               prefixIcon: const Icon(Icons.person, color: AppColor.orange),
//               textInputAction: TextInputAction.next,
//               validator: Validator.email,
//             ),
//             const SizedBox(height: 25.0),
//             CrTextFieldPassword(
//               controller: passwordController,
//               hintText: 'Password',
//               textInputAction: TextInputAction.next,
//               validator: Validator.password,
//             ),
//             const SizedBox(height: 25.0),
//             CrTextFieldPassword(
//               controller: confirmPasswordController,
//               onChanged: (_) => setState(() {}),
//               hintText: 'Confirm Password',
//               textInputAction: TextInputAction.done,
//               validator: Validator.confirmPassword(
//                 passwordController.text,
//               ),
//             ),
//             const SizedBox(height: 25.0),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InkWell(
//                   onTap: () => setState(() => isChecked = !isChecked),
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 6.0, bottom: 6.0),
//                     child: Icon(
//                       isChecked
//                           ? Icons.check_box_outlined
//                           : Icons.check_box_outline_blank,
//                       size: 20.0,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: RichText(
//                     text: TextSpan(
//                       text: 'I agree to your',
//                       style:
//                           const TextStyle(color: Colors.grey, fontSize: 16.0),
//                       children: <TextSpan>[
//                         TextSpan(
//                           recognizer: TapGestureRecognizer()..onTap = () {},
//                           text: ' privacy policy',
//                           style: const TextStyle(
//                               color: Colors.red, fontSize: 16.0),
//                         ),
//                         const TextSpan(text: ' and'),
//                         TextSpan(
//                           recognizer: TapGestureRecognizer()..onTap = () {},
//                           text: ' term & conditions',
//                           style: const TextStyle(
//                               color: Colors.red, fontSize: 16.0),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 60.0),
//             isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : CrElevatedButton(text: 'Register', onPressed: () {}
//                     // _registerUser,
//                     ),
//             const SizedBox(height: 25.0),
//             RichText(
//               text: TextSpan(
//                 text: 'Do you have an account? ',
//                 style: const TextStyle(
//                   fontSize: 16.0,
//                   color: Colors.black,
//                 ),
//                 children: <TextSpan>[
//                   TextSpan(
//                     text: 'Sign in',
//                     style: const TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () => Navigator.of(context).pushAndRemoveUntil(
//                             MaterialPageRoute(
//                               builder: (context) => const LoginPage(),
//                             ),
//                             (Route<dynamic> route) => false,
//                           ),
//                   ),
//                 ],
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/components/text_field/cr_text_field.dart';
import 'package:admin_app/components/text_field/cr_text_field_password.dart';
import 'package:admin_app/constants/app_color.dart';
import 'package:admin_app/gen/assets.gen.dart';
import 'package:admin_app/pages/auth/login_page.dart';
import 'package:admin_app/services/remote/body/auth_services1.dart';
import 'package:admin_app/utils/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode nameFocus = FocusNode();
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final AuthService1 authMethod = AuthService1();

  void _registerUser() async {
    if (formKey.currentState!.validate() && isChecked) {
      setState(() {
        isLoading = true;
      });

      String res = await authMethod.signupUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (res == "success") {
        // Chuyển tới trang tiếp theo hoặc hiển thị thông báo thành công
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      } else {
        // Hiển thị thông báo lỗi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res)),
        );
      }
    } else if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Vui lòng chấp nhận điều khoản và điều kiện")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
              top: MediaQuery.of(context).padding.top + 38.0, bottom: 16.0),
          children: [
            const Text(
              'Register',
              style: TextStyle(color: AppColor.black, fontSize: 26.0),
              textAlign: TextAlign.center,
            ),
            Center(
              child: Image.asset(Assets.images.autocarlogo.path,
                  width: 250.0, fit: BoxFit.cover),
            ),
            const SizedBox(height: 25.0),
            CrTextField(
              controller: nameController,
              focusNode: nameFocus,
              hintText: 'Full Name',
              prefixIcon: const Icon(Icons.person, color: AppColor.orange),
              textInputAction: TextInputAction.next,
              validator: Validator.required,
            ),
            const SizedBox(height: 25.0),
            CrTextField(
              controller: emailController,
              hintText: 'Email',
              prefixIcon: const Icon(Icons.person, color: AppColor.orange),
              textInputAction: TextInputAction.next,
              validator: Validator.email,
            ),
            const SizedBox(height: 25.0),
            CrTextFieldPassword(
              controller: passwordController,
              hintText: 'Password',
              textInputAction: TextInputAction.next,
              validator: Validator.password,
            ),
            const SizedBox(height: 25.0),
            CrTextFieldPassword(
              controller: confirmPasswordController,
              onChanged: (_) => setState(() {}),
              hintText: 'Confirm Password',
              textInputAction: TextInputAction.done,
              validator: Validator.confirmPassword(
                passwordController.text,
              ),
            ),
            const SizedBox(height: 25.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => setState(() => isChecked = !isChecked),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6.0, bottom: 6.0),
                    child: Icon(
                      isChecked
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank,
                      size: 20.0,
                      color: Colors.red,
                    ),
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'I agree to your',
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 16.0),
                      children: <TextSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          text: ' privacy policy',
                          style: const TextStyle(
                              color: Colors.red, fontSize: 16.0),
                        ),
                        const TextSpan(text: ' and'),
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          text: ' term & conditions',
                          style: const TextStyle(
                              color: Colors.red, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60.0),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : CrElevatedButton(
                    text: 'Register',
                    onPressed: _registerUser,
                  ),
            const SizedBox(height: 25.0),
            RichText(
              text: TextSpan(
                text: 'Do you have an account? ',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Sign in',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (Route<dynamic> route) => false,
                          ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
