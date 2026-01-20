//基于Dio进行二次封装
import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

// dio请求工具发出请求 返回的数据 Response<dynamic>.data
// 把所有的接口的data解放出来 拿到真正的数据 要判断业务状态码是不是等于1

//单例对象
final dioRequest = DioRequest();

class DioRequest {
  final _dio = Dio();

  //基础拦截器
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    //添加拦截器
    _addInterceptor();
  }

  //添加拦截器
  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        //请求拦截器
        onRequest: (request, handler) {
          return handler.next(request);
        },
        //响应拦截器
        onResponse: (response, handler) {
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            return handler.next(response);
          }
          return handler.reject(
            DioException(requestOptions: response.requestOptions),
          );
        },
        //错误拦截器
        onError: (error, handler) {
          // return handler.next(error);
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              message: error.response?.data["msg"] ?? " ",
            ),
          );
        },
      ),
    );
  }

  //封装get请求方法
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  //封装post请求方法
  Future<dynamic> post(String url, {Map<String, dynamic>? data}) async {
    return _handleResponse(_dio.post(url, data: data));
  }

  //进一步处理返回结果的函数
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data['code'] == GlobalConstants.SUCCESS_CODE) {
        //http状态和业务状态正常-能正常通过
        return data['result'];
      } else {
        // throw Exception(data['message']);
        throw DioException(
          requestOptions: res.requestOptions,
          message: data["msg"] ?? "加载数据失败",
        );
      }
    } catch (e) {
      // throw Exception(e);
      rethrow; //并没有改变原来抛出的异常的类型
    }
  }
}
