import 'package:get/get.dart';
import 'package:hm_shop/viewmodels/user.dart';

class UserController extends GetxController {
  /// 用户信息控制器，用于管理用户的登录状态和相关信息
  /// 这里使用了GetX的响应式编程，通过.obs将对象变成可监听的对象
  /// Get.put 需要在最初的时候注册控制器。只能注册一次
  /// Get.find 可以在任何地方获取到这个控制器

  // var user = UserInfo.fromJSON({}).obs;  // .obs表示这个对象被监听了
  Rx<UserInfo> user = UserInfo.fromJSON(
    {},
  ).obs; // 这里的var换成Rx<对象类型>也行，但是Rx<UserInfo> 更明确一些
  // 如果想要取这个监听对象的值，需要使用user.value
  void updateUserInfo(UserInfo newUser) {
    user.value = newUser;
  }
}
