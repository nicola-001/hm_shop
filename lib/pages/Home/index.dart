import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/utils/Toastutils.dart';
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
  Future<void> _getBannerList() async {
    _bannerList = await getBannerListAPI();
    print(_bannerList);
  }

  //获取商品列表数据
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    print(_categoryList);
  }

  // 获取特惠推荐数据
  Future<void> _getSuggestionList() async {
    _getProductList = await getProductListAPI();
  }

  //获取爆品推荐列表数据
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
  }

  //获取一站买全数据列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
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

  Future<void> _getRecommendList() async {
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
    //监听注册事件
    _registerEvent();
    //initState -> Future.microtask -> build()执行->
    // microtask 执行，调用 show()
    Future.microtask(() {
      _paddingTop = 100;
      setState(() {});
      _key.currentState?.show();
    });
  }

  //监听滚动到底部的事件
  void _registerEvent() {
    _controller.addListener(() {
      //_controller.position.pixels：当前滚动的位置
      //_controller.position.maxScrollExtent：最大可滚动范围
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

  Future<void> _onRefresh() async {
    _page = 1;
    _isLoading = false;
    _hasMore = true;

    //获取轮播图数据
    await _getBannerList();
    //获取商品列表数据
    await _getCategoryList();
    // 获取特惠推荐数据
    await _getSuggestionList();
    //获取爆品推荐列表数据
    await _getInVogueList();
    //获取一站买全数据列表
    await _getOneStopList();
    await _getRecommendList();
    //数据获取成功
    Toastutils.showToast(context, "刷新成功！");
    _paddingTop = 0;
    setState(() {});
  }

  GlobalKey<RefreshIndicatorState> _key = GlobalKey<RefreshIndicatorState>();
  double _paddingTop = 0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.only(top: _paddingTop),
        child: CustomScrollView(
          //绑定控制器
          controller: _controller,
          slivers: _getScrollChildren(), // sliver家族的内容,
        ),
      ),
    );
  }
}
