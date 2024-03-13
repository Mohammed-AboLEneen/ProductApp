import 'package:dio/dio.dart';

class DioHelper {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: "https://slash-backend.onrender.com/product",
  ));

  static Future<Response> get({
    String? endPoint,
    Map<String, dynamic>? query,
  }) async {
    Response response = await dio.get(
        'https://slash-backend.onrender.com/product/${endPoint ?? ''}',
        queryParameters: query);
    return response;
  }
}
