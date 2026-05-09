import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/catalog_repository.dart';
import 'catalog_event.dart';
import 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final CatalogRepository catalogRepository;

  CatalogBloc({required this.catalogRepository}) : super(CatalogInitial()) {
    on<FetchCatalog>(_onFetchCatalog);
    on<AddCar>(_onAddCar);
    on<UpdateCar>(_onUpdateCar);
    on<DeleteCar>(_onDeleteCar);
  }

  Future<void> _onFetchCatalog(FetchCatalog event, Emitter<CatalogState> emit) async {
    emit(CatalogLoading());
    try {
      final cars = await catalogRepository.getAllCars();
      emit(CatalogLoaded(cars));
    } catch (e) {
      emit(CatalogFailure(e.toString()));
    }
  }

  Future<void> _onAddCar(AddCar event, Emitter<CatalogState> emit) async {
    try {
      await catalogRepository.createCar(event.car);
      emit(const CatalogOperationSuccess('Car added successfully'));
      add(FetchCatalog());
    } catch (e) {
      emit(CatalogFailure(e.toString()));
    }
  }

  Future<void> _onUpdateCar(UpdateCar event, Emitter<CatalogState> emit) async {
    try {
      await catalogRepository.updateCar(event.car);
      emit(const CatalogOperationSuccess('Car updated successfully'));
      add(FetchCatalog());
    } catch (e) {
      emit(CatalogFailure(e.toString()));
    }
  }

  Future<void> _onDeleteCar(DeleteCar event, Emitter<CatalogState> emit) async {
    try {
      await catalogRepository.deleteCar(event.id);
      emit(const CatalogOperationSuccess('Car deleted successfully'));
      add(FetchCatalog());
    } catch (e) {
      emit(CatalogFailure(e.toString()));
    }
  }
}
