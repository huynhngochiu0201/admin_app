import 'package:flutter/material.dart';
import 'package:admin_app/gen/assets.gen.dart';
import 'package:admin_app/pages/profile/profile_page.dart';
//import 'package:admin_app/models/explore_model.dart';
//import 'package:admin_app/models/seller_model.dart';
// import 'package:admin_app/pages/auth/login_page.dart';
//import 'package:admin_app/pages/manage_seller/shop_page.dart';
import 'package:admin_app/constants/app_color.dart';
//import 'package:admin_app/services/local/theme_shared_prefs.dart';
// import 'package:admin_app/services/remote/body/auth_services.dart';
//import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({
    super.key,
    required this.pageIndex,
  });

  final int pageIndex;

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  // final AuthService _authService =
  //     AuthService(); // Tạo thể hiện của AuthService
  // String? userName; // Biến để lưu trữ tên người dùng

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchUserName(); // Lấy tên người dùng khi khởi tạo trang
  // }

  // // Hàm để lấy thông tin người dùng từ Firestore
  // Future<void> _fetchUserName() async {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser; // Lấy người dùng hiện tại
  //     if (user != null) {
  //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(user.uid)
  //           .get(); // Lấy tài liệu người dùng từ Firestore
  //       setState(() {
  //         userName = userDoc['name']; // Cập nhật tên người dùng
  //       });
  //     }
  //   } catch (e) {
  //     print('Lỗi khi lấy thông tin người dùng: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //final themeSharedPrefs = Provider.of<ThemeSharedPrefs>(context);
    const iconSize = 20.0;
    const iconColor = AppColor.orange;
    const spacer = 6.0;
    const textStyle = TextStyle(color: AppColor.brown, fontSize: 16.5);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Welcome',
              style: TextStyle(color: AppColor.red, fontSize: 20.0)),
          const Text(
            '',
            //userName ?? '-:-', // Hiển thị tên người dùng hoặc dấu nếu chưa có
            style: TextStyle(
                color: AppColor.brown,
                fontSize: 16.8,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 18.0),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: const Row(
              children: [
                Icon(Icons.home, size: iconSize, color: iconColor),
                SizedBox(width: spacer),
                Text('Home', style: textStyle),
              ],
            ),
          ),
          const SizedBox(height: 18.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ));
            },
            behavior: HitTestBehavior.translucent,
            child: const Row(
              children: [
                Icon(Icons.person, size: iconSize, color: iconColor),
                SizedBox(width: spacer),
                Text('My Profile', style: textStyle),
              ],
            ),
          ),
          const SizedBox(height: 18.0),
          // GestureDetector(
          //   behavior: HitTestBehavior.translucent,
          //   child: const Row(
          //     children: [
          //       Icon(Icons.settings, size: iconSize, color: iconColor),
          //       SizedBox(width: spacer),
          //       Text('Setings', style: textStyle),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 18.0),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => ShopPage(
          //             shopModels: shopModel,
          //             explore: explores,
          //           ),
          //         ));
          //   },
          //   behavior: HitTestBehavior.translucent,
          //   child: const Row(
          //     children: [
          //       Icon(Icons.shopify, size: iconSize, color: iconColor),
          //       SizedBox(width: spacer),
          //       Text('Shop', style: textStyle),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 18.0),
          // GestureDetector(
          //   behavior: HitTestBehavior.translucent,
          //   child: const Row(
          //     children: [
          //       Icon(Icons.lock_outline, size: iconSize, color: iconColor),
          //       SizedBox(width: spacer),
          //       Text('Change Password', style: textStyle),
          //     ],
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.only(top: 16.0, right: 20.0),
            height: 1.2,
            color: AppColor.grey,
          ),
          const Spacer(flex: 1),
          Row(
            children: [
              const SizedBox(width: 12.0),
              Expanded(child: Image.asset(Assets.images.autocarlogo.path)),
            ],
          ),
          const Spacer(flex: 2),

          const InkWell(
            // onTap: () async {
            //   await _authService.signOut();
            //   if (mounted) {
            //     Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               const LoginPage()), // Điều hướng đến trang đăng nhập
            //     );
            //   }
            // },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Row(
              children: [
                Icon(Icons.logout, size: iconSize, color: iconColor),
                SizedBox(width: spacer),
                Text('Logout', style: textStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
