import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  Future<Response> post(
      {required String url,
      required String token,
      required body,
      String? contextType,
      Map<String, String>? headers,
    }) async {
    final response = await dio.post(url,
        data: body,
        options: Options(
            contentType: contextType,
            headers: headers ?? {'Authorization': 'Bearer $token'}));
    return response;
  }
}
