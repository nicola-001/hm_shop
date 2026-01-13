import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/Home.dart';

class HmSlider extends StatefulWidget {
  //接收父组件传递过来的数据
  final List<BannerItem> bannerList;

  const HmSlider({super.key, required this.bannerList});

  @override
  State<HmSlider> createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  // 定义controller
  CarouselSliderController _controller = CarouselSliderController();

  // 定义当前索引
  int _currentIndex = 0;

  //构建轮播图
  Widget _getSlider() {
    //获取屏幕宽度
    final screenWidth = MediaQuery.of(context).size.width;
    //返回轮播图插件
    // 根据数据渲染的不同数据选项
    return CarouselSlider(
      carouselController: _controller, // 绑定控制器-点击指示灯切换
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
        autoPlay: true, //自动切换轮播图
        onPageChanged: (index, reason) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }

  //构建搜索栏
  Widget _getGetSearch() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            "搜索...",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  //构建指示灯导航
  Widget _getDots() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.bannerList.length, (int index) {
            return GestureDetector(
              onTap: () {
                _controller.animateToPage(index);
                index = index;
                setState(() {});
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 6,
                width: index == _currentIndex ? 40 : 20,
                margin: EdgeInsetsGeometry.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == _currentIndex ? Colors.white : Colors.white54,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //轮播图--搜索框--指示灯导航
    return Stack(children: [_getSlider(), _getGetSearch(), _getDots()]);
  }
}
