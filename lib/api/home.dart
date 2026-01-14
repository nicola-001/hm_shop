//封装api-返回业务侧要的代码
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/Home.dart';

//封装获取轮播图列表
Future<List<BannerItem>> getBannerListAPI() async {
  //返回请求
  var result = await dioRequest.handleResponse(
    await dioRequest.get(HttpConstants.BANNER_LIST),
  );
  return (result as List).map((item) {
    return BannerItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}

//封装分类商品列表
Future<List<CategoryItem>> getCategoryListAPI() async {
  var result = await dioRequest.handleResponse(
    await dioRequest.get(HttpConstants.CATEGORY_LIST),
  );
  return (result as List).map((item) {
    return CategoryItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}
