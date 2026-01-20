import 'package:flutter/material.dart';

class Toastutils {
  static void showToast(BuildContext context, String? msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        content: Text(msg ?? "加载成功！！", textAlign: TextAlign.center),
      ),
    );
  }
}
