import 'package:admin_app/pages/service/widget/area_page.dart';
import 'package:admin_app/pages/service/widget/wheel_size_page.dart';
import 'package:flutter/material.dart';

import 'widget/payload_page.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AreaPage()));
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Area', style: TextStyle(fontSize: 16.0)),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WheelSizePage()));
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Wheel Size', style: TextStyle(fontSize: 16.0)),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PayloadPage()));
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Payload', style: TextStyle(fontSize: 16.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
