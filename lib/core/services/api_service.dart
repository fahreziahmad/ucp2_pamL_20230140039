import 'package:dio/dio.dart';
import 'token_storage.dart';

class ApiService {
  final Dio dio;
  final TokenStorage tokenStorage;

  ApiService({required this.tokenStorage})
      : dio = Dio(
          BaseOptions(
            baseUrl: 'http://10.0.2.2:3000/api', // Sesuaikan port
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 3),
          ),
        ) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await tokenStorage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }
}
