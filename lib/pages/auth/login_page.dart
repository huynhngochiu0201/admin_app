import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/components/snack_bar/show_snack_bar.dart';
import 'package:admin_app/components/text_field/cr_text_field.dart';
import 'package:admin_app/components/text_field/cr_text_field_password.dart';
import 'package:admin_app/constants/app_color.dart';
import 'package:admin_app/gen/assets.gen.dart';
import 'package:admin_app/pages/auth/forgot_password_page.dart';
import 'package:admin_app/pages/main_page.dart';
import 'package:admin_app/services/remote/body/auth_services1.dart';
import 'package:admin_app/utils/validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    String res = await AuthService1().loginUser(
        email: emailController.text, password: passwordController.text);

    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainPage(
            title: 'Hello',
          ),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
              top: MediaQuery.of(context).padding.top + 20.0,
              bottom: 16.0,
            ),
            child: ListView(
              children: [
                const Text(
                  'Sign in',
                  style: TextStyle(color: AppColor.black, fontSize: 26.0),
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: Image.asset(Assets.images.autocarlogo.path,
                      width: 250.0, fit: BoxFit.cover),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CrTextField(
                  controller: emailController,
                  hintText: 'Email or Phone',
                  prefixIcon: const Icon(Icons.email, color: Colors.orange),
                  validator: Validator.email,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 25.0),
                CrTextFieldPassword(
                  controller: passwordController,
                  hintText: 'Password',
                  validator: Validator.password,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 25.0,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CrElevatedButton(
                        text: 'Sign in',
                        color: AppColor.bglogin,
                        borderColor: AppColor.bglogin,
                        onPressed: loginUser,
                      ),
                const SizedBox(height: 25.0),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).pushAndRemoveUntil(
                //       MaterialPageRoute(
                //         builder: (context) => const ForgotPasswordPage(),
                //       ),
                //       (Route<dynamic> route) => false,
                //     );
                //   },
                //   child: const Text(
                //     style: TextStyle(
                //         color: AppColor.black,
                //         fontSize: 16.0,
                //         fontWeight: FontWeight.w600),
                //     'Forgot your Password?',
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                // const SizedBox(height: 40.0),
                // const Text(
                //   'or Login With',
                //   style: TextStyle(
                //       color: AppColor.brown1,
                //       fontSize: 14.8,
                //       fontWeight: FontWeight.w500),
                //   textAlign: TextAlign.center,
                // ),
                // CrElevatedButton(
                //   onPressed: () {},
                //   text: 'Login with Facebook',
                //   color: AppColor.bgfb,
                //   borderColor: AppColor.white,
                // ),
                // const SizedBox(
                //   height: 25.0,
                // ),
                // CrElevatedButton(
                //   onPressed: () {},
                //   text: 'Login with Google',
                //   color: AppColor.bggg,
                //   borderColor: AppColor.white,
                // ),
                // const SizedBox(height: 135.0),
                // Center(
                //   child: RichText(
                //     text: TextSpan(
                //       text: 'Don\'t have an account, ',
                //       style: const TextStyle(
                //         fontSize: 16.0,
                //         color: Colors.black,
                //       ),
                //       children: <TextSpan>[
                //         TextSpan(
                //           text: 'Register',
                //           style: const TextStyle(
                //               fontSize: 16.0, fontWeight: FontWeight.bold),
                //           recognizer: TapGestureRecognizer()
                //             ..onTap = () =>
                //                 Navigator.of(context).pushAndRemoveUntil(
                //                   MaterialPageRoute(
                //                     builder: (context) => const RegisterPage(),
                //                   ),
                //                   (Route<dynamic> route) => false,
                //                 ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
