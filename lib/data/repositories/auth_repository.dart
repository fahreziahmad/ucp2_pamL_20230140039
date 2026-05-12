import 'package:dio/dio.dart';
import '../../core/services/api_service.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository({required this.apiService});

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await apiService.dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });
      
      if (response.data != null && response.data['data'] != null) {
        return Map<String, dynamic>.from(response.data['data']);
      }
      throw Exception('Format data login salah');
    } on DioException catch (e) {
      final message = e.response?.data != null && e.response?.data['message'] != null
          ? e.response?.data['message']
          : 'Login gagal: ${e.message}';
      throw Exception(message);
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<Map<String, dynamic>> register(String username, String password) async {
    try {
      final response = await apiService.dio.post('/auth/register', data: {
        'username': username,
        'password': password,
      });
      
      if (response.data != null && response.data['data'] != null) {
        return Map<String, dynamic>.from(response.data['data']);
      }
      throw Exception('Format data registrasi salah');
    } on DioException catch (e) {
      final message = e.response?.data != null && e.response?.data['message'] != null
          ? e.response?.data['message']
          : 'Registrasi gagal: ${e.message}';
      throw Exception(message);
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
