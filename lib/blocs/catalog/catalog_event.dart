import 'package:equatable/equatable.dart';
import '../../data/models/car_model.dart';

abstract class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object?> get props => [];
}

class FetchCatalog extends CatalogEvent {}

class AddCar extends CatalogEvent {
  final CarModel car;
  const AddCar(this.car);

  @override
  List<Object?> get props => [car];
}

class UpdateCar extends CatalogEvent {
  final CarModel car;
  const UpdateCar(this.car);

  @override
  List<Object?> get props => [car];
}

class DeleteCar extends CatalogEvent {
  final int id;
  const DeleteCar(this.id);

  @override
  List<Object?> get props => [id];
}
