import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/catalog/catalog_bloc.dart';
import 'blocs/category/category_bloc.dart';
import 'blocs/category/category_event.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/catalog_repository.dart';
import 'data/repositories/category_repository.dart';
import 'core/services/token_storage.dart';
import 'ui/screens/splash_screen.dart';
import 'utils/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: locator<AuthRepository>(),
            tokenStorage: locator<TokenStorage>(),
          )..add(AppStarted()),
        ),
        BlocProvider(
          create: (context) => CatalogBloc(
            catalogRepository: locator<CatalogRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            categoryRepository: locator<CategoryRepository>(),
          )..add(FetchCategories()),
        ),
      ],
      child: MaterialApp(
        title: 'MotoEase',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1e3c72)),
          useMaterial3: true,
          fontFamily: 'Inter',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
