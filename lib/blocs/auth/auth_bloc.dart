import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import '../../core/services/token_storage.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final TokenStorage tokenStorage;

  AuthBloc({required this.authRepository, required this.tokenStorage}) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final token = await tokenStorage.getToken();
      final username = await tokenStorage.getUsername();
      if (token != null && username != null) {
        emit(AuthAuthenticated(username));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authRepository.login(event.username, event.password);
        await tokenStorage.saveToken(result['token'], event.username);
        emit(AuthAuthenticated(event.username));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        // Hanya mendaftar saja, tidak menyimpan token
        await authRepository.register(event.username, event.password);
        emit(AuthRegisterSuccess()); // Emit status baru: Sukses Daftar
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await tokenStorage.clear();
      emit(AuthUnauthenticated());
    });
  }
}
