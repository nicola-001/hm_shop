import 'package:flutter/cupertino.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/Home.dart';

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

  @override
  void initState() {
    super.initState();
    //获取轮播图数据
    _getBannerList();
    //获取商品列表数据
    _getCategoryList();
    // 获取特惠推荐数据
    _getSuggestionList();
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
              Expanded(child: HmHot()),
              SizedBox(width: 10),
              Expanded(child: HmHot()),
            ],
          ),
        ),
      ),
      // 间距
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 无限滚动列表
      HmMoreList(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren()); //sliver家族的内容
  }
}
