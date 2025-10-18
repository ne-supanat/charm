import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../global/constant.dart';
import '../global/sharedpref.dart';

class Client {
  final Dio dio;

  Client({required this.dio});

  void configureDio() {
    // Set default configs
    dio.options.baseUrl = baseUrl;

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        error: true,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          final String? authToken = GetIt.I<Sharedpref>().getAuthToken();

          if (authToken != null) {
            options.headers['Authorization'] = 'Bearer $authToken';
          }
          options.headers['Access-Control-Allow-Origin'] = '*';

          // Do something before request is sent.
          // If you want to resolve the request with custom data,
          // you can resolve a `Response` using `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject with a `DioException` using `handler.reject(dioError)`.
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // Do something with response data.
          // If you want to reject the request with a error message,
          // you can reject a `DioException` object using `handler.reject(dioError)`.
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          // Do something with response error.
          // If you want to resolve the request with some custom data,
          // you can resolve a `Response` object using `handler.resolve(response)`.
          return handler.resolve(
            Response(
              requestOptions: error.requestOptions,
              statusCode: error.response?.statusCode,
              statusMessage: error.response?.statusMessage,
              data: error.response?.data,
            ),
          );
          // return handler.next(
          //   DioException(requestOptions: error.requestOptions, error: error.response?.data),
          // );
        },
      ),
    );
  }
}
