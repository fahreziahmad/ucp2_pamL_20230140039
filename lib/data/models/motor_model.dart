import 'package:equatable/equatable.dart';

class MotorModel extends Equatable {
  final int id;
  final String name;
  final String model;
  final int year;
  final int? categoryId;
  final String? categoryName;
  final double pricePerDay;
  final String status;
  final String? imageUrl;

  const MotorModel({
    required this.id,
    required this.name,
    required this.model,
    required this.year,
    this.categoryId,
    this.categoryName,
    required this.pricePerDay,
    required this.status,
    this.imageUrl,
  });

  factory MotorModel.fromJson(Map<String, dynamic> json) {
    return MotorModel(
      id: json['id'],
      name: json['name'],
      model: json['model'],
      year: json['year'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      pricePerDay: double.parse(json['price_per_day'].toString()),
      status: json['status'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'model': model,
      'year': year,
      'category_id': categoryId,
      'price_per_day': pricePerDay,
      'status': status,
      'image_url': imageUrl,
    };
  }

  @override
  List<Object?> get props => [id, name, model, year, categoryId, categoryName, pricePerDay, status, imageUrl];
}
