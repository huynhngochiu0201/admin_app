import 'package:flutter/material.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/constants/app_color.dart';

class AppDialog {
  AppDialog._();

  static void dialog(
    BuildContext context, {
    required title,
    required content,
    Function()? action,
  }) {
    showDialog(
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
                  action?.call();
                  Navigator.pop(context);
                },
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                text: 'Yes',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: CrElevatedButton.smallOutline(
                  onPressed: () => Navigator.pop(context),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  text: 'No',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
