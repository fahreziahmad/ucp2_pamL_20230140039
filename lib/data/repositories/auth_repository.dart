import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../providers/api_provider.dart';

class AuthRepository {
  final ApiProvider apiProvider;

  AuthRepository({required this.apiProvider});

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await apiProvider.dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });

      if (response.data['status'] == 'success') {
        final token = response.data['data']['token'];
        final userData = response.data['data']['user'];
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        
        return {
          'user': UserModel.fromJson(userData),
          'token': token,
        };
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception(e.response?.data['message'] ?? 'Login failed');
      }
      rethrow;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }
}
