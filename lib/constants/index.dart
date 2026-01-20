//定义全局常量数据：基础地址、超时时间、业务状态、请求地址
class GlobalConstants {
  static const String BASE_URL = "https://meikou-api.itheima.net"; //基础地址
  static const int TIME_OUT = 10; //超时时间
  static const String SUCCESS_CODE = "1"; //成功状态
  static const String TOKEN_KEY = "hm_shop_token";
}

//请求地址接口常量
class HttpConstants {
  //轮播图地址
  static const String BANNER_LIST = "/home/banner";

  //商品列表地址
  static const String CATEGORY_LIST = "/home/category/head";

  // 特惠推荐
  static const String SPECIAL_RECOMMEND = "/hot/preference";

  //爆款推荐地址
  static const String IN_VOGUE_LIST = "/hot/inVogue";

  //一站买全地址
  static const String ONE_SHOP_API = "/hot/oneStop";

  //推荐列表
  static const String RECOMMEND_LIST = "/home/recommend";

  //猜你喜欢
  static const String GUESS_LIST = "/home/goods/guessLike"; //返回的是GoodsItems类型

  //登录
  static const String LOGIN = "/login";
}
