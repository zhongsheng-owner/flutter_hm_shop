import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 定义数据 根据数据进行渲染4个导航
  // 一般应用程序的导航是固定的
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/ic_public_home_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_home_active.png", // 激活显示的图标
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_pro_active.png", // 激活显示的图标
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_cart_active.png", // 激活显示的图标
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_my_active.png", // 激活显示的图标
      "text": "我的",
    },
  ];

  int _currentIndex = 0;

  // 渲染底部渲染的四个分类
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (int index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tabList[index]["active_icon"]!,
          width: 30,
          height: 30,
        ),
        label: _tabList[index]["text"],
      );
    });
  }

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  void initState() {
    super.initState();
    // 初始化用户
    _initUser();
  }

  //  注册用户信息的全局store对象,  put方法只能一次
  final UserController _userController = Get.put(UserController());

  void _initUser() async {
    await tokenManager.init(); // 初始化token管理器
    if (tokenManager.getToken().isNotEmpty) {
      // 如果有token 就请求用户信息
      _userController.updateUserInfo(await getUserInfoAPI());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea 避开安全区组件
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getChildren()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          // index就是当前点击的索引

          _currentIndex = index;
          setState(() {});
        },
        currentIndex: _currentIndex,
        items: _getTabBarWidget(),
      ),
    );
  }
}
