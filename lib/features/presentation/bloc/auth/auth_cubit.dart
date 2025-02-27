import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/auth_usecase/auth_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecase _authUsecase;

  AuthCubit({required AuthUsecase authUsecase})
      : _authUsecase = authUsecase,
        super(const AuthState(status: AuthStatus.unknown));

  Future<bool> loadAuthenticationState() async {
    final isAuthenticated = await _authUsecase.isAuthenticated();
    //load as soon as we know auth status and it is safe to call get current session
    if (isAuthenticated) {
      authenticated();
      return true;
    } else {
      unauthenticated();
      return false;
    }
  }

  void authenticated() => emit(const AuthState.authenticated());

  void unauthenticated() => emit(const AuthState.unauthenticated());

  void reset() => emit(const AuthState(status: AuthStatus.unknown));

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
  }
}

bool authCubitChangeTrigger(AuthState previous, AuthState current) {
  return previous.status != current.status &&
      current.status != AuthStatus.unknown &&
      previous.status != AuthStatus.unknown;
}
