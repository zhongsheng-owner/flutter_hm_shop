// 基于Dio进行二次封装
import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

class DioRequest {
  final _dio = Dio();

  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);

    // 拦截器
    _addInterceptors();
  }

  // 添加拦截器
  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          // 打印请求信息
          print('请求地址：${request.uri}');
          return handler.next(request); // continue
        },
        onResponse: (response, handler) {
          // 打印响应信息
          print('响应数据：${response.data}');
          // http状态码 200 300
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            return handler.next(response); // continue
          }
          return handler.reject(
            DioException(requestOptions: response.requestOptions),
          ); // continue
        },
        onError: (error, handler) {
          handler.reject(error);
        },
      ),
    );
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  // 进一步处理返回结果的函数
  // dio请求工具发出请求 返回的数据 Response<dynamic>.data
  // 把所有的接口的data解放出来，拿到真正的数据 要判断业务状态码是不是等于1
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>; //data才是我们真实的接口返回的数据
      if (data['code'] == GlobalConstants.SUCCESS_CODE) {
        return data['result']; //只要result数据
      }
      throw Exception(data['message'] ?? "请求数据异常");
    } catch (e) {
      throw Exception(e);
    }
  }
}

// 单例对象
final dioRequest = DioRequest(); // 单例对象
