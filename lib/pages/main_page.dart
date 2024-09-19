import 'package:admin_app/pages/home/oder/oder_page.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/components/navigator/app_bottomnavbar1.dart';
import 'package:admin_app/components/app_bar/cr_app_bar.dart';
import 'package:admin_app/components/cr_zoom_drawer.dart';
import 'package:admin_app/pages/home/category/category_page.dart';
import 'package:admin_app/pages/home/drawer_page.dart';
import 'package:admin_app/pages/home/home_page.dart';

import 'package:admin_app/pages/profile/profile_page.dart';
import 'package:admin_app/constants/app_color.dart';
import 'package:admin_app/pages/home/product/product_page.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.title,
    this.pageIndex,
  });

  final String title;
  final int? pageIndex;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final zoomDrawerController = ZoomDrawerController();
  late int selectedIndex;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.pageIndex ?? 0;
  }

  toggleDrawer() {
    zoomDrawerController.toggle?.call();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: CrAppBar(
          leftPressed: toggleDrawer,
          rightPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ProfilePage(),
          )),
          title: widget.title,
        ),
        body: CrZoomDrawer(
          controller: zoomDrawerController,
          menuScreen: DrawerPage(pageIndex: selectedIndex),
          screen: IndexedStack(
            index: currentIndex,
            children: const [
              HomePage(),
              OderPage(),
              CategoryPage(),
              ProductPage(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBarCurvedFb1(
          selected: currentIndex,
          onPressed: (p0) {
            setState(() {
              currentIndex = p0;
            });
          },
        ),
      ),
    );
  }
}
