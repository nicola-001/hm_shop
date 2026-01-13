//封装api-返回业务侧要的代码
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/Home.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  //返回请求
  var result = await dioRequest.handleResponse(
    await dioRequest.get(HttpConstants.BANNER_LIST)
  );
  return (result as List).map((item) {
    return BannerItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}
