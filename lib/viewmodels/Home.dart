// flutter必须强制转化 没有隐式转化
class BannerItem {
  String id;
  String imgUrl;

  BannerItem({required this.id, required this.imgUrl});

  //扩展工厂函数  一般用factory来声明，一般用来创建实例对象
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(id: json['id'] ?? "", imgUrl: json['imgUrl'] ?? "");
  }
}

//编写class对象
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;

  //编写同名的构造函数
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });

  //扩展工厂函数  一般用factory来声明，一般用来创建实例对象
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      picture: json['picture'] ?? "",
      children: json['children'] == null
          ? null
          : (json['children'] as List)
          .map((item) => CategoryItem.fromJson(item as Map<String, dynamic>))
          .toList()
    );
  }
}
