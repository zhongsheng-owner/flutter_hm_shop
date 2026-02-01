import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Hot extends StatefulWidget {
  final SpecialRecommendResult result;
  final String type;
  const Hot({super.key, required this.result, required this.type});

  @override
  State<Hot> createState() => _HotState();
}

class _HotState extends State<Hot> {
  // 获取前两条数据(通过计算属性方式实现  使用时无需像函数一样需要（）来调用，直接使用变量名即可获取值)
  List<GoodsItem> get _items {
    if (widget.result.subTypes.isEmpty) return [];
    return widget.result.subTypes.first.goodsItems.items.take(2).toList();
  }

  // 构建子项
  List<Widget> _getChildrenList() {
    return _items
        .map(
          (item) => Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.picture,
                    width: 80,
                    height: 100,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "lib/assets/home_cmd_inner.png",
                        width: 80,
                        height: 100,
                      );
                    },
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '¥${item.price}',
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color.fromARGB(255, 86, 24, 20),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.type == "step" ? "一站买全" : "爆款推荐",
          style: TextStyle(
            fontSize: 18,
            color: const Color.fromARGB(255, 86, 24, 20),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          widget.type == "step" ? "精心优选" : "最受欢迎",
          style: TextStyle(
            fontSize: 12,
            color: const Color.fromARGB(255, 124, 63, 58),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.type == "step"
              ? Color.fromARGB(255, 249, 247, 219)
              : Color.fromARGB(255, 211, 228, 240),
        ),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _getChildrenList(),
            ),
          ],
        ),
      ),
    );
  }
}
