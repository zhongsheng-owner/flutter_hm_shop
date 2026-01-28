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
  // 获取轮播图组件
  Widget _getSlider() {
    // 在flutter中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width;

    return CarouselSlider(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Stack -> 轮播图 搜索框 指示灯导航
    return Stack(children: [_getSlider()]);

    // return Container(
    //   height: 300,
    //   color: Colors.blue,
    //   alignment: Alignment.center,
    //   child: Text("轮播图", style: TextStyle(color: Colors.white, fontSize: 20)),
    // );
  }
}
