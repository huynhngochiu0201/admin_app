import 'package:admin_app/components/app_bar/td_snack_bar.dart';
import 'package:admin_app/components/app_bar/top_snack_bar.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/components/text_field/cr_text_field.dart';
import 'package:admin_app/components/text_field/cr_text_field_password.dart';
import 'package:admin_app/constants/app_color.dart';
import 'package:admin_app/services/local/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../gen/assets.gen.dart';
import '../../models/user_model.dart';
import '../../utils/validator.dart';
import '../main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.email});

  final String? email;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final _auth = FirebaseAuth.instance;

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users'); // tham chieu

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email ?? '';
  }

  Future<void> _submitLogin(BuildContext context) async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    setState(() => isLoading = true);
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text)
        .then((value) {
      _getUser();
    }).catchError((onError) {
      setState(() => isLoading = false);
      showTopSnackBar(
        context,
        const TDSnackBar.error(message: 'Email or Password is wrong😐'),
      );
    });
  }

  void _getUser() {
    userCollection
        .doc(emailController.text)
        .get()
        .then((snapshot) {
          final data = snapshot.data() as Map<String, dynamic>;
          SharedPrefs.user = UserModel.fromJson(data);
          if (!context.mounted) return;
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const MainPage(title: 'Hello'),
            ),
            (route) => false,
          );
        })
        .catchError((onError) {})
        .whenComplete(
          () {
            setState(() => isLoading = false);
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                top: MediaQuery.of(context).padding.top + 38.0, bottom: 16.0),
            children: [
              const Center(
                child: Text(
                  'Sign in',
                  style: TextStyle(color: AppColor.black, fontSize: 26.0),
                ),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: Image.asset(Assets.images.autocarlogo.path,
                    width: 250.0, fit: BoxFit.cover),
              ),
              const SizedBox(height: 36.0),
              CrTextField(
                controller: emailController,
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email, color: Colors.orange),
                validator: Validator.email,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20.0),
              CrTextFieldPassword(
                controller: passwordController,
                hintText: 'Password',
                validator: Validator.password,
                onFieldSubmitted: (_) => _submitLogin(context),
                textInputAction: TextInputAction.done,
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //       onTap: () => Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => const RegisterPage(),
              //       )),
              //       child: const Text(
              //         'Register',
              //         style: TextStyle(color: AppColor.red, fontSize: 16.0),
              //       ),
              //     ),
              //     const Text(
              //       ' | ',
              //       style: TextStyle(color: AppColor.orange, fontSize: 16.0),
              //     ),
              //     GestureDetector(
              //       child: const Text(
              //         'Forgot Password?',
              //         style: TextStyle(color: AppColor.brown, fontSize: 16.0),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 40.0),
              CrElevatedButton(
                onPressed: () => _submitLogin(context),
                text: 'Sign in',
                isDisable: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
