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
    // return CategoryItem(id: json['id'], name: json['name']);
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
