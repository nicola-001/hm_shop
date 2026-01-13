import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';

import '../Cart/index.dart';
import '../Category/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 定义数据 根据数据进行渲染四个导航
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/ic_public_home_normal.png", //正常显示的图标
      "active_icon": "lib/assets/ic_public_home_active.png", //激活显示图标
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png", //正常显示的图标
      "active_icon": "lib/assets/ic_public_pro_active.png", //激活显示图标
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png", //正常显示的图标
      "active_icon": "lib/assets/ic_public_cart_active.png", //激活显示图标
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png", //正常显示的图标
      "active_icon": "lib/assets/ic_public_my_active.png", //激活显示图标
      "text": "我的",
    },
  ];

  // 声明变量
  int _currentIndex = 0;

  //返回底部导航
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (int index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tabList[index]["active_icon"]!,
          width: 30,
          height: 30,
        ),
        label: _tabList[index]["text"],
      );
    });
  }

  List<Widget> _getChildren() {
    return [HomeView(), CatrgoryView(), CartView(), MineView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getChildren()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //选中文字的颜色
        selectedItemColor: Colors.black,
        //未选中的文本
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          print(index);
          _currentIndex = index;
          setState(() {});
        },
        currentIndex: _currentIndex,
        items: _getTabBarWidget(),
      ),
    );
  }
}
