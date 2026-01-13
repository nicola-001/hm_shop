//基于Dio进行二次封装
import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

class DioRequest {
  final _dio = Dio();

  //基础拦截器
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalContanstant.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalContanstant.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalContanstant.TIME_OUT);
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
          return handler.next(error);
        },
      ),
    );
  }

  //封装get请求方法
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _dio.get(url, queryParameters: params);
  }

  //进一步处理返回结果的函数
  Future<dynamic> handleResponse<T>(Response<dynamic> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data['code'] == GlobalContanstant.SUCCESS_CODE) {
        //http状态和业务状态正常-能正常通过
        return data['result'];
      } else {
        throw Exception(data['message']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

//单例对象
final dioRequest = DioRequest();

// dio请求工具发出请求 返回的数据 Response<dynamic>.data
// 把所有的接口的data解放出来 拿到真正的数据 要判断业务状态码是不是等于1
