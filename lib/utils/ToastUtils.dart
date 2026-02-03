import 'package:flutter/material.dart';

class Toastutils {
  static void showToast(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40), // 圆角
        ),
        behavior: SnackBarBehavior.floating, // 浮动在底部
        duration: Duration(seconds: 2), // 持续时间
        content: Text(message ?? "加载成功", textAlign: TextAlign.center),
      ),
    );
  }
}
