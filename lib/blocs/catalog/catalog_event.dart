import 'package:equatable/equatable.dart';
import '../../data/models/motor_model.dart';

abstract class CatalogEvent extends Equatable {
  const CatalogEvent();
  @override
  List<Object?> get props => [];
}

class FetchCatalog extends CatalogEvent {
  final String? search;
  const FetchCatalog({this.search});
  @override
  List<Object?> get props => [search];
}

class AddMotor extends CatalogEvent {
  final MotorModel motor;
  const AddMotor(this.motor);
  @override
  List<Object?> get props => [motor];
}

class UpdateMotor extends CatalogEvent {
  final MotorModel motor;
  const UpdateMotor(this.motor);
  @override
  List<Object?> get props => [motor];
}

class DeleteMotor extends CatalogEvent {
  final int id;
  const DeleteMotor(this.id); // Constructor satu argumen posisi
  @override
  List<Object?> get props => [id];
}
