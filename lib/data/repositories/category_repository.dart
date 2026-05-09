import 'package:dio/dio.dart';
import '../models/category_model.dart';
import '../providers/api_provider.dart';

class CategoryRepository {
  final ApiProvider apiProvider;

  CategoryRepository({required this.apiProvider});

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final response = await apiProvider.dio.get('/categories');
      final List data = response.data;
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> createCategory(String name, String? description) async {
    try {
      await apiProvider.dio.post('/categories', data: {
        'name': name,
        'description': description,
      });
    } catch (e) {
      throw Exception('Failed to create category');
    }
  }
}
