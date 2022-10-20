import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as Res;
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:dio/adapter.dart';
import 'storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../global.dart';

/*
  * http 操作类
  *
  * 手册
  * https://github.com/flutterchina/dio/blob/master/README-ZH.md#formdata
  *
  * 从2.1.x升级到 3.x
  * https://github.com/flutterchina/dio/blob/master/migration_to_3.0.md
*/
class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;
  late Dio dio;

  CancelToken cancelToken = CancelToken();

  HttpUtil._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions(
      // 请求基地址,可以包含子路径
      // baseUrl: baseUrl,

      // baseUrl: storage.read(key: STORAGE_KEY_APIURL) ?? SERVICE_API_BASEURL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 60 * 1000,

      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 50 * 1000,

      // Http请求头.
      headers: {},

      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
      contentType: 'application/json; charset=utf-8',

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      ///
      /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      ///
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    // 解决unable to get local issuer certificate(https ssl 证书)问题 start
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
      return client;
    };
    // 解决unable to get local issuer certificate(https ssl 证书)问题 end

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
      // print(baseUrl + options.path);
      // print(options.data);

      // dynamic data = mockDataWithPath(options.path);
      // if (data != null) {
      //   Res.Response s = Res.Response(requestOptions: options, data: data);
      //   return handler.resolve(s);
      // }
      return handler.next(options);
    }, onResponse: (response, handler) {
      // print(response);
      //上传图片的statusCode是201
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('error....');
        if (response.statusCode == 410 && Get.currentRoute != AppRoutes.login) {
          Get.offAllNamed(AppRoutes.login);
          final global = Get.put(GlobalConfigService());
          // global.loginOut();
        }

        handler.reject(DioError(
            requestOptions: response.requestOptions,
            type: DioErrorType.response,
            error: ErrorEntity(
                code: response.statusCode, message: response.data['message'])));
      } else {
        var jsonView = json.decode(response.toString());
        if (jsonView['errors'] != null) {
          var errorList = List<dynamic>.from(jsonView['errors']);
          var err = json.decode(errorList[0]?['extensions']?['details']);
          print(err);

          handler.reject(DioError(
            requestOptions: response.requestOptions,
            type: DioErrorType.response,
            error: ErrorEntity(
              code: 500,
              message: err['Message'] ?? 'Unknown error',
            ),
          ));
        } else {
          handler.next(Res.Response(
              requestOptions: response.requestOptions, data: response));
        }
      }
    }));
  }

  /*
   * error统一处理
   */
  // 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    print('444444');
    print(error);
    if (error.error is ErrorEntity) {
      EasyLoading.showError(error.error.message ?? 'Operation failed');
      return error.error;
    }
    switch (error.type) {
      case DioErrorType.cancel:
        return ErrorEntity(code: -1, message: "cancel");
      case DioErrorType.connectTimeout:
        {
          return ErrorEntity(code: -1, message: "connectTimeout");
        }
      case DioErrorType.sendTimeout:
        {
          return ErrorEntity(code: -1, message: "sendTimeout");
        }
      case DioErrorType.receiveTimeout:
        {
          return ErrorEntity(code: -1, message: "receiveTimeout");
        }
      case DioErrorType.response:
        {
          try {
            int? errCode = error.response!.statusCode;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 409:
              case 401:
                {
                  Get.offAllNamed(AppRoutes.login);
                  return ErrorEntity(
                      code: errCode, message: "token is invalied");
                }
              case 400:
              case 403:
              case 404:
              case 405:
              case 500:
              case 502:
              case 503:
                {
                  return ErrorEntity(code: errCode, message: error.message);
                }
              case 505:
                {
                  return ErrorEntity(
                      code: errCode,
                      message: "HTTP requests are not supported");
                }
              default:
                {
                  return ErrorEntity(
                      code: errCode, message: error.response!.statusMessage!);
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "unknown error");
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  /// 读取本地配置
  Options getLocalOptions() {
    late Options options;
    String token = StorageUtil().getStr('accessToken');
    if (token != '') {
      options = Options(headers: {
        'Authorization': 'Bearer $token',
      });
    } else {
      options = Options();
    }
    return options;
  }

  /// restful get 操作
  Future get(String path,
      {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var tokenOptions = options ?? getLocalOptions();
      var response = await dio.get(path,
          queryParameters: params,
          options: tokenOptions,
          cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  /// restful post 操作
  Future post(String path,
      {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var tokenOptions = options ?? getLocalOptions();
      var response = await dio.post(path,
          data: params, options: tokenOptions, cancelToken: CancelToken());
      return response.data;
    } on DioError catch (e) {
      if (e.type != DioErrorType.cancel) throw createErrorEntity(e);
    }
  }

  /// restful put 操作
  Future put(String path,
      {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var tokenOptions = options ?? getLocalOptions();
      var response = await dio.put(path,
          data: params, options: tokenOptions, cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  /// restful delete 操作
  Future delete(String path,
      {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var tokenOptions = options ?? getLocalOptions();
      var response = await dio.delete(path,
          data: params, options: tokenOptions, cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  /// restful post form 表单提交操作
  Future postForm(String path,
      {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      String? token = '';
      var tokenOptions = options ?? getLocalOptions();
      tokenOptions.headers!.addAll({'Authorization': token});
      var response = await dio.post(path,
          data: params, options: tokenOptions, cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }
}

// 异常处理
class ErrorEntity implements Exception {
  int? code;
  String? message;

  ErrorEntity({this.code, this.message});

  @override
  String toString() {
    if (message == null) return "Exception";
    return "Exception: code $code, $message";
  }
}
