import 'package:flutter/material.dart';

import 'package:admin_app/components/app_bar/custom_app_bar.dart';
import 'package:admin_app/pages/profile/widget/widget_profile.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Profile',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 40,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 1,
                        'Hiếu',
                        style: TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        maxLines: 2,
                        'hieuhuynh.0201@gmail.com',
                        style: TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'General',
                  style: TextStyle(fontSize: 20.0),
                )),
            const SizedBox(height: 20.0),
            CrLisTile(
              text: 'All orders',
              image: SvgPicture.asset(
                'assets/icons/add-image-photo-icon.svg',
                width: 30.0,
              ),
              function: () {},
            ),
            const SizedBox(height: 10.0),
            CrLisTile(
              text: 'Wishlist',
              image: SvgPicture.asset(
                'assets/icons/add-image-photo-icon.svg',
                width: 30.0,
              ),
              function: () {},
            ),
            const SizedBox(height: 10.0),
            CrLisTile(
              text: 'Viewed recently',
              image: SvgPicture.asset(
                'assets/icons/add-image-photo-icon.svg',
                width: 30.0,
              ),
              function: () {},
            ),
            const SizedBox(height: 10.0),
            CrLisTile(
              text: 'Address',
              image: SvgPicture.asset(
                'assets/icons/add-image-photo-icon.svg',
                width: 30.0,
              ),
              function: () {},
            )
          ],
        ),
      ),
    );
  }
}
