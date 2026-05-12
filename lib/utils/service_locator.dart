import 'package:get_it/get_it.dart';
import '../core/services/api_service.dart';
import '../core/services/token_storage.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/catalog_repository.dart';
import '../data/repositories/category_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Services
  locator.registerLazySingleton<TokenStorage>(() => TokenStorage());
  locator.registerLazySingleton<ApiService>(
    () => ApiService(tokenStorage: locator<TokenStorage>()),
  );

  // Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepository(apiService: locator<ApiService>()),
  );
  locator.registerLazySingleton<CatalogRepository>(
    () => CatalogRepository(apiService: locator<ApiService>()),
  );
  locator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepository(apiService: locator<ApiService>()),
  );
}
