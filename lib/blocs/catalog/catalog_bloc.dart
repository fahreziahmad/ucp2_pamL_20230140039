import 'package:flutter_bloc/flutter_bloc.dart';
import 'catalog_event.dart';
import 'catalog_state.dart';
import '../../data/repositories/catalog_repository.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final CatalogRepository catalogRepository;

  CatalogBloc({required this.catalogRepository}) : super(CatalogLoading()) {
    on<FetchCatalog>((event, emit) async {
      emit(CatalogLoading());
      try {
        final motors = await catalogRepository.getAllMotors(search: event.search);
        if (motors.isEmpty) {
          emit(CatalogEmpty());
        } else {
          emit(CatalogLoaded(motors));
        }
      } catch (e) {
        emit(CatalogError(e.toString()));
      }
    });

    on<AddMotor>((event, emit) async {
      try {
        await catalogRepository.addMotor(event.motor);
        add(const FetchCatalog()); 
      } catch (e) {
        emit(CatalogError(e.toString()));
      }
    });

    on<UpdateMotor>((event, emit) async {
      try {
        await catalogRepository.updateMotor(event.motor);
        add(const FetchCatalog());
      } catch (e) {
        emit(CatalogError(e.toString()));
      }
    });

    on<DeleteMotor>((event, emit) async {
      try {
        await catalogRepository.deleteMotor(event.id);
        add(const FetchCatalog());
      } catch (e) {
        emit(CatalogError(e.toString()));
      }
    });
  }
}
