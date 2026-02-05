// 声明轮播图的类型
class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  // 拓展一个工厂函数 一般用factory来声明 一般用来创建实例对象
  factory BannerItem.formJSON(Map<String, dynamic> json) {
    return BannerItem(id: json['id'] ?? "", imgUrl: json['imgUrl'] ?? "");
  }
}

// 声明分类的类
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });
  factory CategoryItem.formJSON(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
      children: json['children'] == null
          ? null
          : (json['children'] as List)
                .map(
                  (item) => CategoryItem.formJSON(item as Map<String, dynamic>),
                )
                .toList(),
    );
  }
}

// 特惠推荐 - 商品信息
class GoodsItem {
  String id;
  String name;
  String desc;
  String price;
  String picture;
  int orderNum;
  GoodsItem({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });
  factory GoodsItem.formJSON(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      desc: json['desc'] ?? '',
      price: json['price'] ?? '',
      picture: json['picture'] ?? '',
      orderNum: json['orderNum'] ?? 0,
    );
  }
}

// 特惠推荐 - 商品分类信息
class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;
  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsItems.formJSON(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      pages: json['pages'] ?? 0,
      page: json['page'] ?? 0,
      items: (json['items'] as List? ?? [])
          .map((item) => GoodsItem.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

// 特惠推荐 - 子类型
class SubType {
  String id;
  String title;
  GoodsItems goodsItems;
  SubType({required this.id, required this.title, required this.goodsItems});
  factory SubType.formJSON(Map<String, dynamic> json) {
    return SubType(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      goodsItems: GoodsItems.formJSON(
        json['goodsItems'] as Map<String, dynamic>,
      ),
    );
  }
}

// 特惠推荐 - 结果
class SpecialRecommendResult {
  String id;
  String title;
  List<SubType> subTypes;
  SpecialRecommendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });
  factory SpecialRecommendResult.formJSON(Map<String, dynamic> json) {
    return SpecialRecommendResult(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subTypes: (json['subTypes'] as List? ?? [])
          .map((item) => SubType.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

// 列表列类型
class GoodDetailItem extends GoodsItem {
  int payCount = 0;

  // 商品详情页
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.picture,
    required super.price,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");

  // 工厂函数
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      picture: json['picture']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      orderNum: int.tryParse(json['orderNum']?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json['payCount']?.toString() ?? "0") ?? 0,
    );
  }
}

// 我的页面中的猜你喜欢的商品列表
class GoodsDetailsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodDetailItem> items;
  GoodsDetailsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsDetailsItems.formJSON(Map<String, dynamic> json) {
    return GoodsDetailsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      pages: json['pages'] ?? 0,
      page: json['page'] ?? 0,
      items: (json['items'] as List? ?? [])
          .map((item) => GoodDetailItem.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}