import 'package:shared_preferences/shared_preferences.dart';

import '../constants/index.dart';

class TokenManager {
  //返回持久化实例对象
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  String _token = '';

  init() async {
    SharedPreferences prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  Future<void> setToken(String val) async {
    //1.获取持久化实例
    SharedPreferences prefs = await _getInstance();
    //2.保存数据
    await prefs.setString(GlobalConstants.TOKEN_KEY, val);
    _token = val;
  }

  //获取token 确保是一个同步方法
  String getToken() {
    return _token;
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await _getInstance();
    await prefs.remove(GlobalConstants.TOKEN_KEY); //磁盘
    _token = ''; //内存
  }
}

//单例模式
final tokenManager = TokenManager();
