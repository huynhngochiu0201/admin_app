import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';

class CrLisTile extends StatelessWidget {
  const CrLisTile(
      {super.key,
      required this.image,
      required this.text,
      required this.function});
  final Widget image;
  final String text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: image,
      title: Text(text),
      trailing: const Icon(IconlyLight.arrow_right_2),
    );
  }
}
