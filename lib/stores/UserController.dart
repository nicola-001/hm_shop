import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hm_shop/viewmodels/User.dart';

/*
1.安装getx插件
2.定义一个继承GetxController的对象
3.对象中定义需要共享的属性
4.数据需要响应式更新-需要给初始值.obs结尾
5.UI显示Getx数据需使用Obx包裹函数中使用
6.UI中使用Getx需要一个put和find动作
7.必须先put一次，才可以find8.put仅一次,find可多次
* */
//需要共享的对象、属性、属性需要响应式更新
class Usercontroller extends GetxController {
  var user = UserInfo.fromJSON({}).obs; //user对象被监听了

  //想要取值需要使用user.value.属性
  void updateUser(UserInfo newUser) {
    user.value = newUser;
  }


}
