import '../../core/services/api_service.dart';
import '../models/motor_model.dart';

class CatalogRepository {
  final ApiService apiService;

  CatalogRepository({required this.apiService});

  Future<List<MotorModel>> getAllMotors({String? search}) async {
    try {
      final response = await apiService.dio.get(
        '/catalog',
        queryParameters: search != null ? {'search': search} : null,
      );
      
      // Mengambil data dari properti 'data' karena backend menggunakan responseHelper
      final List dynamicList = response.data['data'];
      return dynamicList.map((json) => MotorModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load motors: $e');
    }
  }

  Future<void> addMotor(MotorModel motor) async {
    try {
      await apiService.dio.post('/catalog', data: motor.toJson());
    } catch (e) {
      throw Exception('Failed to add motor: $e');
    }
  }

  Future<void> updateMotor(MotorModel motor) async {
    try {
      await apiService.dio.put('/catalog/${motor.id}', data: motor.toJson());
    } catch (e) {
      throw Exception('Failed to update motor: $e');
    }
  }

  Future<void> deleteMotor(int id) async {
    try {
      await apiService.dio.delete('/catalog/$id');
    } catch (e) {
      throw Exception('Failed to delete motor: $e');
    }
  }
}
