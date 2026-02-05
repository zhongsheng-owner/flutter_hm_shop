import 'package:flutter/material.dart';

class ToastUtils {
  // 阀门控制, 防止一定时间内多次点击导致多次弹出
  static bool isShow = false;

  static void showToast(BuildContext context, String? message) {
    if (isShow) return;
    ToastUtils.isShow = true;
    Future.delayed(Duration(seconds: 3), () {
      ToastUtils.isShow = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40), // 圆角
        ),
        behavior: SnackBarBehavior.floating, // 浮动在底部
        duration: Duration(seconds: 3), // 持续时间
        content: Text(message ?? "加载成功", textAlign: TextAlign.center),
      ),
    );
  }
}
