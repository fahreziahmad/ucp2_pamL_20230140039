import 'package:get_it/get_it.dart';
import '../data/providers/api_provider.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/catalog_repository.dart';
import '../data/repositories/category_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Providers
  locator.registerLazySingleton<ApiProvider>(() => ApiProvider());

  // Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepository(apiProvider: locator<ApiProvider>()),
  );
  locator.registerLazySingleton<CatalogRepository>(
    () => CatalogRepository(apiProvider: locator<ApiProvider>()),
  );
  locator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepository(apiProvider: locator<ApiProvider>()),
  );
}
