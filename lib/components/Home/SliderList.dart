import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class SliderList extends StatefulWidget {
  final List<BannerItem> bannerList;
  const SliderList({super.key, required this.bannerList});

  @override
  State<SliderList> createState() => _SliderListState();
}

class _SliderListState extends State<SliderList> {
  CarouselSliderController _carouselSlideController =
      CarouselSliderController(); //控制轮播图跳转的控制器

  int _currentIndex = 0; // 当前轮播图索引

  // 获取轮播图组件
  Widget _getSlider() {
    // 在flutter中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width;

    return CarouselSlider(
      carouselController: _carouselSlideController, // 绑定controller
      items: List.generate(widget.bannerList.length, (int index) {
        return Image.network(
          widget.bannerList[index].imgUrl,
          fit: BoxFit.cover,
          width: screenWidth,
        );
      }),
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1, // 视口比例 轮播图占满屏幕宽度
        autoPlay: true, // 自动播放
        autoPlayInterval: Duration(seconds: 2), // 自动播放间隔
        onPageChanged: (int index, reason) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }

  // 构建搜索栏组件
  Widget _getSearchBar() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            "搜索...",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  // 构建指示灯导航
  Widget _getIndicator() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.bannerList.length, (int index) {
            return GestureDetector(
              onTap: () {
                _carouselSlideController.animateToPage(index);
              },
              child: AnimatedContainer(
                // 动画效果，点击切换轮播图时，指示灯导航的宽度变化
                duration: Duration(milliseconds: 300),
                height: 6,
                width: index == _currentIndex ? 40 : 20,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == _currentIndex
                      ? Colors.white
                      : Color.fromRGBO(0, 0, 0, 0.3),
                  borderRadius: BorderRadius.circular(3), // 刚好是6的一半，就是圆的
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Stack -> 轮播图 搜索框 指示灯导航
    return Stack(children: [_getSlider(), _getSearchBar(), _getIndicator()]);

    // return Container(
    //   height: 300,
    //   color: Colors.blue,
    //   alignment: Alignment.center,
    //   child: Text("轮播图", style: TextStyle(color: Colors.white, fontSize: 20)),
    // );
  }
}
