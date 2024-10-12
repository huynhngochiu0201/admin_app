import 'package:admin_app/components/snack_bar/td_snack_bar.dart';
import 'package:admin_app/components/snack_bar/top_snack_bar.dart';
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
  final _firestore = FirebaseFirestore.instance;

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users'); // reference

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

    try {
      // Sign in with email and password
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Check the role of the user
      final roleAllowed = await checkRole(emailController.text.trim());

      if (roleAllowed == true || roleAllowed == false) {
        // Role is either admin or staff, proceed to fetch user details
        _getUser();
      } else {
        // Role is neither admin nor staff, show an error message
        setState(() => isLoading = false);
        showTopSnackBar(
          context,
          const TDSnackBar.error(
              message: 'You do not have access to this app 😐'),
        );
        await _auth.signOut(); // Sign out if the user is not allowed to log in
      }
    } catch (error) {
      setState(() => isLoading = false);
      showTopSnackBar(
        context,
        const TDSnackBar.error(message: 'Email or Password is wrong😐'),
      );
    }
  }

  Future<bool?> checkRole(String email) async {
    try {
      final querySnapshot = await _firestore
          .collection('users') // replace with your collection name
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final role = querySnapshot.docs.first;
        if (role['role'] == 'admin') {
          return true;
        } else if (role['role'] == 'staff') {
          return false;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error checking role: $e');
    }
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
        .whenComplete(() {
          setState(() => isLoading = false);
        });
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

// import 'package:admin_app/components/app_bar/td_snack_bar.dart';
// import 'package:admin_app/components/app_bar/top_snack_bar.dart';
// import 'package:admin_app/components/button/cr_elevated_button.dart';
// import 'package:admin_app/components/text_field/cr_text_field.dart';
// import 'package:admin_app/components/text_field/cr_text_field_password.dart';
// import 'package:admin_app/constants/app_color.dart';
// import 'package:admin_app/services/local/shared_prefs.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../gen/assets.gen.dart';
// import '../../models/user_model.dart';
// import '../../utils/validator.dart';
// import '../main_page.dart';
// // import '../staff_page.dart'; // Uncomment if you have a specific StaffPage

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key, this.email});

//   final String? email;

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   bool isLoading = false;

//   final _auth = FirebaseAuth.instance;

//   CollectionReference userCollection = FirebaseFirestore.instance
//       .collection('users'); // Reference to users collection

//   @override
//   void initState() {
//     super.initState();
//     emailController.text = widget.email ?? '';
//   }

//   Future<void> _submitLogin(BuildContext context) async {
//     if (formKey.currentState?.validate() == false) {
//       return;
//     }
//     setState(() => isLoading = true);
//     _auth
//         .signInWithEmailAndPassword(
//             email: emailController.text.trim(),
//             password: passwordController.text)
//         .then((value) {
//       _getUser();
//     }).catchError((onError) {
//       setState(() => isLoading = false);
//       showTopSnackBar(
//         context,
//         const TDSnackBar.error(message: 'Email or Password is wrong😐'),
//       );
//     });
//   }

//   void _getUser() {
//     userCollection.doc(_auth.currentUser?.uid).get().then((snapshot) {
//       final data = snapshot.data() as Map<String, dynamic>;
//       SharedPrefs.user = UserModel.fromJson(data);
//       if (!context.mounted) return;

//       final userRole = data['role'];
//       if (userRole == 'admin') {
//         Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(
//             builder: (_) => const MainPage(title: 'Hello Admin'),
//           ),
//           (route) => false,
//         );
//       } else if (userRole == 'staff') {
//         showTopSnackBar(
//           context,
//           const TDSnackBar.error(message: 'Access Denied for Staff🛑'),
//         );
//       } else {
//         showTopSnackBar(
//           context,
//           const TDSnackBar.error(message: 'Unrecognized role😐'),
//         );
//       }
//     }).catchError((onError) {
//       setState(() => isLoading = false);
//       showTopSnackBar(
//         context,
//         const TDSnackBar.error(
//             message: 'An error occurred while fetching user data😞'),
//       );
//     }).whenComplete(
//       () {
//         setState(() => isLoading = false);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Form(
//           key: formKey,
//           child: ListView(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
//                 top: MediaQuery.of(context).padding.top + 38.0, bottom: 16.0),
//             children: [
//               const Center(
//                 child: Text(
//                   'Sign in',
//                   style: TextStyle(color: AppColor.black, fontSize: 26.0),
//                 ),
//               ),
//               const SizedBox(height: 10.0),
//               Center(
//                 child: Image.asset(Assets.images.autocarlogo.path,
//                     width: 250.0, fit: BoxFit.cover),
//               ),
//               const SizedBox(height: 36.0),
//               CrTextField(
//                 controller: emailController,
//                 hintText: 'Email',
//                 prefixIcon: const Icon(Icons.email, color: Colors.orange),
//                 validator: Validator.email,
//                 textInputAction: TextInputAction.next,
//               ),
//               const SizedBox(height: 20.0),
//               CrTextFieldPassword(
//                 controller: passwordController,
//                 hintText: 'Password',
//                 validator: Validator.password,
//                 onFieldSubmitted: (_) => _submitLogin(context),
//                 textInputAction: TextInputAction.done,
//               ),
//               const SizedBox(height: 40.0),
//               CrElevatedButton(
//                 onPressed: () => _submitLogin(context),
//                 text: 'Sign in',
//                 isDisable: isLoading,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
