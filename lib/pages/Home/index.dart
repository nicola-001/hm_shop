import 'package:flutter/cupertino.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/Home.dart';
import 'package:hm_shop/components/Home/HmHot.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //定义接受数据的变量
  List<BannerItem> _bannerList = [];
  List<CategoryItem> _categoryList = [];
  SpecialRecommendResult _getProductList = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  List<GoodDetailItem> _recommendList = [];

  //获取轮播图数据
  void _getBannerList() async {
    _bannerList = await getBannerListAPI();
    print(_bannerList);
    setState(() {});
  }

  //获取商品列表数据
  void _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    print(_categoryList);
    setState(() {});
  }

  // 获取特惠推荐数据
  void _getSuggestionList() async {
    _getProductList = await getProductListAPI();
    setState(() {});
  }

  //获取爆品推荐列表数据
  void _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  //获取一站买全数据列表
  void _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

  /*
  * 1.使用原有接口实现2.监听滚动到底部事件3.同时只能加载一个请求4.如果没有下一页不能再发起请求
  * */
  //获取推荐列表数据
  // 页码
  int _page = 1;

  //是否正在加载数据
  bool _isLoading = false;

  // 判断是否还有下一页
  bool _hasMore = true;

  void _getRecommendList() async {
    //当已经有请求正在加载 或 已经下一页 就放弃请求
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true; //占住位置
    int requestPage = _page * 8;
    _recommendList = await getRecommendListAPI({"limit": requestPage});
    _isLoading = false; //释放位置
    setState(() {});
    _page++;
    if (_recommendList.length < 8) {
      //判断是否还有下一页
      _hasMore = false;
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    //获取轮播图数据
    _getBannerList();
    //获取商品列表数据
    _getCategoryList();
    // 获取特惠推荐数据
    _getSuggestionList();
    //获取爆品推荐列表数据
    _getInVogueList();
    //获取一站买全数据列表
    _getOneStopList();
    //获取推荐列表数据
    _getRecommendList();

    //监听注册事件
    _registerEvent();
  }

  //监听滚动到底部的事件
  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 50) {
        // 加载第二页数据
        _getRecommendList();
      }
    });
  }

  //获取滚动容器的内容
  List<Widget> _getScrollChildren() {
    //包裹普通容器家族的组件
    return [
      //轮播图组件
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      // 间距
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //商品分类组件
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      // 间距
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 推荐
      SliverToBoxAdapter(
        child: HmSuggestion(specialRecommendResult: _getProductList),
      ),
      // 间距
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 推荐
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
            ],
          ),
        ),
      ),
      // 间距
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 无限滚动列表
      HmMoreList(recommendList: _recommendList),
    ];
  }

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      //绑定控制器
      controller: _controller,
      slivers: _getScrollChildren(),
    ); //sliver家族的内容
  }
}
