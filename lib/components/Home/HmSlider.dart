import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/Home.dart';

class HmSlider extends StatefulWidget {
  //接收负组建传递过来的数据
  final List<BannerItem> bannerList;

  const HmSlider({super.key, required this.bannerList});

  @override
  State<HmSlider> createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  //构建轮播图
  Widget _getSlider() {
    //获取屏幕宽度
    final screenWidth = MediaQuery.of(context).size.width;
    //返回轮播图插件
    // 根据数据渲染的不同数据选项
    return CarouselSlider(
      items: List.generate(widget.bannerList.length, (index) {
        return Image.network(
          widget.bannerList[index].imgUrl,
          fit: BoxFit.cover,
          //在flutter中获取屏幕宽度
          width: screenWidth,
        );
      }),
      options: CarouselOptions(
        autoPlayInterval: Duration(seconds: 5),
        viewportFraction: 1.0,
        autoPlay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //轮播图--搜索框--指示灯导航
    return Stack(children: [_getSlider()]);
  }
}
