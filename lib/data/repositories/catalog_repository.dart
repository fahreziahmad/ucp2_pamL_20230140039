import 'package:dio/dio.dart';
import '../models/car_model.dart';
import '../providers/api_provider.dart';

class CatalogRepository {
  final ApiProvider apiProvider;

  CatalogRepository({required this.apiProvider});

  Future<List<CarModel>> getAllCars() async {
    try {
      final response = await apiProvider.dio.get('/catalog');
      final List data = response.data;
      return data.map((json) => CarModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load catalog');
    }
  }

  Future<void> createCar(CarModel car) async {
    try {
      await apiProvider.dio.post('/catalog', data: car.toJson());
    } catch (e) {
      throw Exception('Failed to create car entry');
    }
  }

  Future<void> updateCar(CarModel car) async {
    try {
      await apiProvider.dio.put('/catalog/${car.id}', data: car.toJson());
    } catch (e) {
      throw Exception('Failed to update car entry');
    }
  }

  Future<void> deleteCar(int id) async {
    try {
      await apiProvider.dio.delete('/catalog/$id');
    } catch (e) {
      throw Exception('Failed to delete car entry');
    }
  }
}
