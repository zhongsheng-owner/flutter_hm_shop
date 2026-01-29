import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Category extends StatefulWidget {
  // 列表数据
  final List<CategoryItem> categoryList;
  const Category({super.key, required this.categoryList});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    // 这里不能只能返回ListView, 因为它不能设置高度，不设置高度显示不了
    // return ListView();
    // 所以这里使用SizedBox包裹，并设置高度为100
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // 设置水平滚动方向
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          final CategoryItem category = widget.categoryList[index];
          return Container(
            alignment: Alignment.center,
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 231, 232, 234),
              borderRadius: BorderRadius.circular(40),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(category.picture, width: 40, height: 40),
                Text(category.name, style: TextStyle(color: Colors.black)),
              ],
            ),
          );
        },
      ),
    );
  }
}
