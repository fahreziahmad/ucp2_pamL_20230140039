import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/category_model.dart';
import '../../data/repositories/category_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

export 'category_event.dart';
export 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({required this.categoryRepository}) : super(CategoryInitial()) {
    on<FetchCategories>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = await categoryRepository.getAllCategories();
        emit(CategoryLoaded(List<CategoryModel>.from(categories)));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });

    on<AddCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        // Menggunakan parameter bernama dari event
        await categoryRepository.addCategory(event.name, event.description); 
        emit(CategorySuccess());
        add(FetchCategories());
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });

    on<DeleteCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        // Menggunakan parameter bernama dari event
        await categoryRepository.deleteCategory(event.id);
        emit(CategorySuccess());
        add(FetchCategories());
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }
}
