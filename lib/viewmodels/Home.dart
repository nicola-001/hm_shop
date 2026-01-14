// flutter必须强制转化 没有隐式转化

// 轮播图-class
class BannerItem {
  String id;
  String imgUrl;

  BannerItem({required this.id, required this.imgUrl});

  //扩展工厂函数  一般用factory来声明，一般用来创建实例对象
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(id: json['id'] ?? "", imgUrl: json['imgUrl'] ?? "");
  }
}

// 分类列表-class
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
                .map(
                  (item) => CategoryItem.fromJson(item as Map<String, dynamic>),
                )
                .toList(),
    );
  }
}

// 特惠推荐-class
//特惠推荐-商品项
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

  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      desc: json['desc']?.toString() ?? "",
      price: json['price']?.toString() ?? "",
      picture: json['picture']?.toString() ?? "",
      orderNum: int.tryParse(json['orderNum']?.toString() ?? "0") ?? 0,
    );
  }
}

//特惠推荐-商品分页信息
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
  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'] is int ? json['counts'] : int.tryParse(json['counts']?.toString() ?? "0") ?? 0,
      pageSize: json['pageSize'] is int ? json['pageSize'] : int.tryParse(json['pageSize']?.toString() ?? "0") ?? 0,
      pages: json['pages'] is int ? json['pages'] : int.tryParse(json['pages']?.toString() ?? "0") ?? 0,
      page: json['page'] is int ? json['page'] : int.tryParse(json['page']?.toString() ?? "0") ?? 0,
      items: (json['items'] as List? ?? [])
          .map((item) => GoodsItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

//特惠推荐-子类型
class SubTypes {
  String id;
  String title;
  GoodsItems goodsItems;

  SubTypes({required this.id, required this.title, required this.goodsItems});

  factory SubTypes.fromJson(Map<String, dynamic> json) {
    return SubTypes(
      id: json['id']?.toString() ?? "",
      title: json['title']?.toString() ?? "",
      goodsItems: GoodsItems.fromJson(
        json['goodsItems'] as Map<String, dynamic>,
      ),
    );
  }
}

//特惠推荐-结果
class SpecialRecommendResult {
  String id;
  String title;
  List<SubTypes> subTypes;

  SpecialRecommendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory SpecialRecommendResult.fromJson(Map<String, dynamic> json) {
    return SpecialRecommendResult(
      id: json['id']?.toString() ?? "",
      title: json['title']?.toString() ?? "",
      subTypes: (json['subTypes'] as List? ?? [])
          .map((item) => SubTypes.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

