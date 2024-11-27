import 'package:flutter/material.dart';
import 'package:admin_app/constants/app_color.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBarCurvedFb1 extends StatefulWidget {
  const BottomNavBarCurvedFb1({
    super.key,
    required this.onPressed,
    required this.selected,
  });
  final Function(int) onPressed;
  final int selected;

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarCurvedFb1State createState() => _BottomNavBarCurvedFb1State();
}

class _BottomNavBarCurvedFb1State extends State<BottomNavBarCurvedFb1> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    double height = 56;

    // const backgroundColor = Colors.white;

    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavBarIcon(
                  text: "Home",
                  icon: Icons.home_outlined,
                  selected: widget.selected == 0,
                  onPressed: () => widget.onPressed(0),
                  defaultColor: AppColor.secondaryColor,
                  selectedColor: AppColor.primaryColor,
                ),
                NavBarIcon(
                  text: "Order",
                  svgIcon: 'assets/icons/package-add-icon.svg',
                  selected: widget.selected == 1,
                  onPressed: () => widget.onPressed(1),
                  defaultColor: AppColor.secondaryColor,
                  selectedColor: AppColor.primaryColor,
                ),
                NavBarIcon(
                    text: "Category",
                    svgIcon: 'assets/icons/category-icon.svg',
                    selected: widget.selected == 2,
                    onPressed: () => widget.onPressed(2),
                    defaultColor: AppColor.secondaryColor,
                    selectedColor: AppColor.primaryColor),
                NavBarIcon(
                  text: "Product",
                  svgIcon: 'assets/icons/noun-add-product-6282309.svg',
                  selected: widget.selected == 3,
                  onPressed: () => widget.onPressed(3),
                  selectedColor: AppColor.primaryColor,
                  defaultColor: AppColor.secondaryColor,
                ),
                NavBarIcon(
                  text: "Product",
                  svgIcon: 'assets/icons/noun-add-product-6282309.svg',
                  selected: widget.selected == 4,
                  onPressed: () => widget.onPressed(4),
                  selectedColor: AppColor.primaryColor,
                  defaultColor: AppColor.secondaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({
    super.key,
    required this.text,
    this.icon,
    required this.selected,
    required this.onPressed,
    this.svgIcon,
    this.selectedColor = const Color(0xffFF8527),
    this.defaultColor = Colors.black54,
  });
  final String text;
  final IconData? icon;
  final String? svgIcon;
  final bool selected;
  final Function() onPressed;
  final Color defaultColor;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 30,
              color: selected ? selectedColor : defaultColor,
            ),
          ] else if (svgIcon != null) ...[
            SvgPicture.asset(
              svgIcon!,
              height: 30, // Adjust the size
              color: selected
                  ? selectedColor
                  : defaultColor, // Apply color if needed
            ),
          ],
          Text(
            text,
            style: TextStyle(
                fontSize: 13, color: selected ? Colors.black : Colors.black26),
          )
        ],
      ),
    );
  }
}
