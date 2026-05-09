import 'package:equatable/equatable.dart';
import '../../data/models/car_model.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object?> get props => [];
}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<CarModel> cars;
  const CatalogLoaded(this.cars);

  @override
  List<Object?> get props => [cars];
}

class CatalogOperationSuccess extends CatalogState {
  final String message;
  const CatalogOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CatalogFailure extends CatalogState {
  final String message;
  const CatalogFailure(this.message);

  @override
  List<Object?> get props => [message];
}
