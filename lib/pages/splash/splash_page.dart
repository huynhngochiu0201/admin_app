// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:admin_app/gen/assets.gen.dart';
// import 'package:admin_app/pages/auth/login_page.dart';
// import 'package:admin_app/pages/onboarding/onboarding_page.dart';
// import 'package:admin_app/resources/app_color.dart';
// import 'package:admin_app/services/local/shared_prefs.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   late SharedPrefsOnboarding prefs;
//   bool? seenOnboard;

//   @override
//   void initState() {
//     super.initState();
//     // Khởi tạo SharedPreferences
//     prefs = SharedPrefsOnboarding();
//     // Kiểm tra xem đã xem onboarding hay chưa
//     checkOnboardingStatus();
//   }

//   // Hàm kiểm tra trạng thái của onboarding
//   Future<void> checkOnboardingStatus() async {
//     seenOnboard = await prefs.getSeenOnboard();
//     // Luôn hiển thị màn hình Splash trong 2 giây
//     await Future.delayed(const Duration(milliseconds: 2000));

//     // Nếu đã xem onboarding, chuyển đến màn hình tiếp theo
//     if (seenOnboard != null && seenOnboard!) {
//       navigateToNextScreen();
//     } else {
//       // Nếu chưa xem onboarding, hiển thị trang onboarding và lưu lại trạng thái đã xem
//       await prefs.saveSeenOnboard(true);
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const OnboardingPage(),
//         ),
//         (Route<dynamic> route) => false,
//       );
//     }
//   }

//   // Hàm chuyển đến màn hình tiếp theo
//   void navigateToNextScreen() {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginPage()),
//       (Route<dynamic> route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: AppColor.white,
//       body: Container(
//         width: size.width,
//         height: size.height,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage(Assets.images.autocarlogo.path))),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:admin_app/gen/assets.gen.dart';
import 'package:admin_app/pages/auth/login_page.dart';
import 'package:admin_app/pages/onboarding/onboarding_page.dart';
import 'package:admin_app/constants/app_color.dart';
import 'package:admin_app/services/local/shared_prefs.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SharedPrefsOnboarding prefs;
  bool? seenOnboard;

  @override
  void initState() {
    super.initState();
    prefs = SharedPrefsOnboarding();
    checkOnboardingStatus();
  }

  Future<void> checkOnboardingStatus() async {
    seenOnboard = await prefs.getSeenOnboard();
    await Future.delayed(const Duration(milliseconds: 2000));

    if (!mounted) return;

    if (seenOnboard != null && seenOnboard!) {
      navigateToLogin();
    } else {
      navigateToOnboarding();
    }
  }

  void navigateToLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  void navigateToOnboarding() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.autocarlogo.path),
          ),
        ),
      ),
    );
  }
}
