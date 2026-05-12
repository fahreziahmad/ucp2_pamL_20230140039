import '../../core/services/api_service.dart';
import '../models/category_model.dart';

class CategoryRepository {
  final ApiService apiService;

  CategoryRepository({required this.apiService});

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final response = await apiService.dio.get('/categories');
      final List dynamicList = response.data['data'];
      return dynamicList.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<void> addCategory(String name, String description) async {
    try {
      await apiService.dio.post('/categories', data: {'name': name, 'description': description});
    } catch (e) {
      throw Exception('Failed to add category: $e');
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      await apiService.dio.delete('/categories/$id');
    } catch (e) {
      throw Exception('Failed to delete category: $e');
    }
  }
}
