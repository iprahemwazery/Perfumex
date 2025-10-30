import 'package:dio/dio.dart';
import 'package:perfumex/core/network/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://perfumes.wazery.net/wp-json/wc/v3/',
      headers: {"Content-Type": 'application/json'},
    ),
  );

  DioClient() {
    // _dio.interceptors.add(
    //   LogInterceptor(requestBody: true, responseBody: true),
    // );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();
          print(' API Request to: ${options.path}');
          print(' Token for request: ${token ?? 'null'}');

          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
            print('Authorization header added');
          } else {
            print('No authorization header added');
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
