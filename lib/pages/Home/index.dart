import 'package:flutter/cupertino.dart';
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
  final List<BannerItem> _bannerList = [
    BannerItem(
      id: "1",
      imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg",
    ),
    BannerItem(
      id: "2",
      imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png",
    ),
    BannerItem(
      id: "3",
      imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg",
    ),
  ];

  //获取滚动容器的内容
  List<Widget> _getScrollChildren() {
    //包裹普通容器家族的组件
    return [
      //轮播图组件
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList,)),
      // 间距
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //商品分类组件
      SliverToBoxAdapter(child: HmCategory()),
      // 间距
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 推荐
      SliverToBoxAdapter(child: HmSuggestion()),
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
