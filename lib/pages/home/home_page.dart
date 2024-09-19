import 'package:admin_app/constants/app_color.dart';
import 'package:admin_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Card(
                  color: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.article,
                              size: 30.0,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              "Order",
                              style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.icons.boxPackageIcon,
                              color: AppColor.black,
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            const Text(
                              "Total Sale",
                              style: TextStyle(
                                fontSize: 26.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          "",
                          style: TextStyle(
                            fontSize: 26.0,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Card(
                  color: Colors.yellow,
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.monetization_on_outlined,
                              size: 30.0,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              "Total Product",
                              style: TextStyle(
                                fontSize: 26.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
