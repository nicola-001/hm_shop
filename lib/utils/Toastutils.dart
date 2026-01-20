import 'package:flutter/material.dart';

class Toastutils {
  //阀门控制
  static bool isShow = false;

  static void showToast(BuildContext context, String? msg) {
    if (isShow) {
      return;
    }
    isShow = true;
    Future.delayed(Duration(seconds: 3), () {
      isShow = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 200,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        content: Text(msg ?? "加载成功！！", textAlign: TextAlign.center),
      ),
    );
  }
}
