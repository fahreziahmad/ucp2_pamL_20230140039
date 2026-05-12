import 'package:equatable/equatable.dart';
import '../../data/models/motor_model.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();
  @override
  List<Object?> get props => [];
}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<MotorModel> motors;
  const CatalogLoaded(this.motors);
  @override
  List<Object?> get props => [motors];
}

class CatalogEmpty extends CatalogState {}

class CatalogError extends CatalogState {
  final String message;
  const CatalogError(this.message);
  @override
  List<Object?> get props => [message];
}
