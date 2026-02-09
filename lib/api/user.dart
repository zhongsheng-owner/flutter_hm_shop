// 登录接口API
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/user.dart';

// 登录接口请求方法
Future<UserInfo> loginAPI(Map<String, dynamic> params) async {
  return UserInfo.fromJSON(
    await dioRequest.post(HttpConstants.LOGIN, params: params),
  );
}
