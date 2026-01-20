// 导入 GoodDetailItem 类型
import './Home.dart' show GoodDetailItem;

//猜你喜欢 - 分页响应
class GuessListResult {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodDetailItem> items;

  GuessListResult({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GuessListResult.fromJson(Map<String, dynamic> json) {
    return GuessListResult(
      counts: json['counts'] is int
          ? json['counts']
          : int.tryParse(json['counts']?.toString() ?? "0") ?? 0,
      pageSize: json['pageSize'] is int
          ? json['pageSize']
          : int.tryParse(json['pageSize']?.toString() ?? "0") ?? 0,
      pages: json['pages'] is int
          ? json['pages']
          : int.tryParse(json['pages']?.toString() ?? "0") ?? 0,
      page: json['page'] is int
          ? json['page']
          : int.tryParse(json['page']?.toString() ?? "0") ?? 0,
      items: (json['items'] as List? ?? [])
          .map((item) => GoodDetailItem.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}