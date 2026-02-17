
import 'package:get/get.dart';
import 'package:hm_shop/viewmodels/user.dart';

class UserController extends GetxController{
  // var user = UserInfo.fromJSON({}).obs;  // .obs表示这个对象被监听了
  Rx<UserInfo> user = UserInfo.fromJSON({}).obs;  // 这里的var换成Rx<对象类型>也行，但是Rx<UserInfo> 更明确一些
  // 如果想要取这个监听对象的值，需要使用user.value
  void updateUserInfo(UserInfo newUser){
    user.value = newUser;
  }
}