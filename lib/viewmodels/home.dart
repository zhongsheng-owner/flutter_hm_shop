// 声明轮播图的类型
class BannerItem{
  String id;
  String imgUrl;
  BannerItem({required this.id,required this.imgUrl});
  // 拓展一个工厂函数 一般用factory来声明 一般用来创建实例对象
  factory BannerItem.formJSON(Map<String,dynamic> json){
    return BannerItem(id: json['id'],imgUrl: json['imgUrl']);
  }
}