import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
  @override
  List<Object?> get props => [];
}

class FetchCategories extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  final String name;
  final String description;
  const AddCategory({required this.name, required this.description});
  @override
  List<Object?> get props => [name, description];
}

class DeleteCategory extends CategoryEvent {
  final int id;
  const DeleteCategory({required this.id});
  @override
  List<Object?> get props => [id];
}
