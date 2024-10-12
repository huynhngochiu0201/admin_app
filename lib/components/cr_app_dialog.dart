import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/constants/app_color.dart';
import 'package:flutter/material.dart';

class CrAppDialog {
  CrAppDialog._();

  static Future<bool> dialog(
    BuildContext context, {
    required String title,
    required String content,
  }) async {
    final bool? confirmed = await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(
          content,
          style: const TextStyle(color: AppColor.brown, fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CrElevatedButton.smallOutline(
                onPressed: () {
                  Navigator.pop(context, true); // Trả về true nếu nhấn "Yes"
                },
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                text: 'Yes',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: CrElevatedButton.smallOutline(
                  onPressed: () => Navigator.pop(context, false), // Trả về false nếu nhấn "No"
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  text: 'No',
                ),
              ),
            ],
          ),
        ],
      ),
    );
    return confirmed ?? false; // Mặc định trả về false nếu người dùng đóng dialog
  }
}
