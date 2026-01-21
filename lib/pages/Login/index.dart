import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/User.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';
import 'package:hm_shop/utils/ToastUtils.dart';

import '../../utils/LogingDialog.dart';
/*
*
* 1.Form组件=>TextFormField 可实现表单校验
* 2.使用GlobalKey创建key绑定Form组件可调用valiate方法
* 3.TextFormField的validator返回校验文本
* 4.正则表达式使用RegExp(r")进行校验
* */

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController(); // 账号控制器
  TextEditingController _codeController = TextEditingController(); // 密码控制器
  // 用户账号Widget

  // 头部Widget
  final Usercontroller _usercontroller = Get.find();

  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // 用户账号Widget
  Widget _buildPhoneTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "手机号不能为空";
        }
        //校验手机号格式
        if (!RegExp(r"^1[3456789]\d{9}$").hasMatch(value)) {
          return "请输入正确的手机号";
        }
      },
      controller: _phoneController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        // 内容内边距
        hintText: "请输入账号",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  // 用户密码Widget
  Widget _buildCodeTextField() {
    //TextFormFiled
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "密码不能为空";
        }
        //设置6-16位的数字字母下划线
        if (!RegExp(r"^[a-zA-Z0-9_]{6,16}$").hasMatch(value)) {
          return "请输入正确的密码";
        }
      },
      controller: _codeController,
      obscureText: true, //设置为密文
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        // 内容内边距
        hintText: "请输入密码",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  bool _isChecked = false;

  // 勾选Widget
  Widget _buildCheckbox() {
    return Row(
      children: [
        // 设置勾选为圆角
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            _isChecked = value ?? false;
            setState(() {});
          },
          // 设置形状
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 圆角大小
          ),
          // 可选：设置边框
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "查看并同意"),
              TextSpan(
                text: "《隐私条款》",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: "和"),
              TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 登录逻辑
  void _login() async {
    LogingDialog.show(context, message: "登录中...");
    try {
      final res = await loginAPI({
        "account": _phoneController.text,
        "password": _codeController.text,
      });
      _usercontroller.updateUser(res);
      await tokenManager.setToken(res.token);
      Toastutils.showToast(context, "登录成功");
      Navigator.of(context).pop();
    } catch (e) {
      Toastutils.showToast(context, (e as DioException).message);
    }
  }

  // 登录按钮Widget
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 登录逻辑
          if (_key.currentState!.validate()) {
            if (_isChecked) {
              _login();
            } else {
              // 登录失败
              Toastutils.showToast(context, "请先阅读并同意隐私条款和用户协议");
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text("登录", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  //创建key
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  //Form组件和TextFormFiled实现表单校验
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 30),
              _buildPhoneTextField(),
              SizedBox(height: 20),
              _buildCodeTextField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
