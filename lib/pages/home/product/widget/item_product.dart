import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatefulWidget {
  const ItemProduct({super.key});

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  bool isExpanded = false;
  String? text = 'This is an example text that will be truncated if too long. '
      'When you click "Read more", the full text will be shown.'
      'This is an example text that will be truncated if too long. '
      'When you click "Read more", the full text will be shown.'
      'This is an example text that will be truncated if too long. '
      'When you click "Read more", the full text will be shown.'
      'This is an example text that will be truncated if too long. '
      'When you click "Read more", the full text will be shown.'
      'This is an example text that will be truncated if too long. '
      'When you click "Read more", the full text will be shown.'
      'This is an example text that will be truncated if too long. '
      'When you click "Read more", the full text will be shown.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 411,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40.0),
                        child: Image.network(
                          "https://scontent.fdad1-3.fna.fbcdn.net/v/t39.30808-6/336997038_1259177801623608_8284020166899583608_n.jpg?stp=dst-jpg_s1080x2048&_nc_cat=110&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeE9je6otCZqQOZr-IKc0yAM_L0_Q7kO7qr8vT9DuQ7uqsMh8jFVfYt-sKemQda7kIfMuY3qIvswssvtnhMLenFA&_nc_ohc=g9-wvnoKitsQ7kNvgGwsANG&_nc_ht=scontent.fdad1-3.fna&_nc_gid=A0vysMkjYjkbCgi9r5Kyh-c&oh=00_AYDXyyj6Fh4BUGTZ1UHIRqc2i591mgdqFKWFqW_SgS9qaA&oe=66EF5A84",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 24,
                      left: 10,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            //color: ,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            //color: AppColor.hFFFFFF,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const Text('data'),
              const Text('\$'),
              RichText(
                text: TextSpan(
                  text: isExpanded || text!.length <= 200
                      ? text
                      : text!.substring(0, 200),
                  style: const TextStyle(color: Colors.black),
                  children: [
                    if (!isExpanded && text!.length > 200)
                      TextSpan(
                        text: '... Read more',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              isExpanded = true;
                            });
                          },
                      ),
                    if (isExpanded && text!.length > 200)
                      TextSpan(
                        text: ' Show less',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              isExpanded = false;
                            });
                          },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CrElevatedButton(
                    onPressed: () {},
                    text: '',
                    icon: const Icon(Icons.delete),
                  ),
                  CrElevatedButton(
                    onPressed: () {},
                    text: '',
                    icon: const Icon(Icons.edit),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
