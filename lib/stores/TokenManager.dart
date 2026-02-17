import 'package:hm_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  // 返回持久化对象的实例对象
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  String _token = "";

  // 初始化token
  Future<void> init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  // 设置token
  Future<void> setToken(String val) async {
    // 1.获取持久化实例
    final prefs = await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY, val);
    _token = val;
  }

  // 获取token
  String getToken() {
    return _token;
  }

  // 删除token
  Future<void> removeToken() async {
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY); // 磁盘
    _token = ""; // 内存
  }
}

final tokenManager = TokenManager();
