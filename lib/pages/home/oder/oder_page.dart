import 'package:admin_app/constants/app_color.dart';
import 'package:flutter/material.dart';

class OderPage extends StatefulWidget {
  const OderPage({super.key});

  @override
  OderPageState createState() => OderPageState();
}

class OderPageState extends State<OderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 30.0),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            width: 90.0,
                            // height: 126.0,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(22.0),
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://scontent.fdad1-3.fna.fbcdn.net/v/t39.30808-6/336997038_1259177801623608_8284020166899583608_n.jpg?stp=dst-jpg_s1080x2048&_nc_cat=110&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeE9je6otCZqQOZr-IKc0yAM_L0_Q7kO7qr8vT9DuQ7uqsMh8jFVfYt-sKemQda7kIfMuY3qIvswssvtnhMLenFA&_nc_ohc=g9-wvnoKitsQ7kNvgGwsANG&_nc_ht=scontent.fdad1-3.fna&_nc_gid=AoKb1IAzyNH6ftWEacoDqh7&oh=00_AYBknEzW5JQTV1U7DuQiqxIAOzoWZ2NqWXgSBDEj_lpavg&oe=66EF2244'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    maxLines: 1,
                                    'hello hello hello hello hello hello hello hello hello ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    '\$:21313111 ',
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    maxLines: 1,
                                    'Quantyti:100 ',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    maxLines: 1,
                                    'TIMES',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                iconSize: 30,
                                onPressed: () {},
                                icon: const Icon(Icons.cancel,
                                    color: AppColor.red),
                              ),
                              IconButton(
                                iconSize: 30,
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.done, color: AppColor.red),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
