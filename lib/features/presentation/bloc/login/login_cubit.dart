import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/enums/login_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;
  LoginCubit({required this.loginUsecase}) : super(LoginInitialState());

  Future<void> onLoginSubmit(String username, String password) async {
    emit(LoginLoadingState());

    final loginStatus = await loginUsecase.attemptSignIn(username, password);
    switch (loginStatus) {
      case LoginStatus.loginSuccessBiometric:
        emit(const LoginSuccessState(showBiometricOptionView: true));
        break;
      case LoginStatus.loginSuccessBillToShipTo:
        emit(const LoginSuccessState(showBiometricOptionView: false));
        break;
      case LoginStatus.loginErrorOffline:
        emit(
          LoginFailureState(
            title: SiteMessageConstants.defaultMobileAppAlertNoInternet,
            message:
                SiteMessageConstants.defaultMobileAppAlertNoInternetDescription,
            buttonText: LocalizationConstants.Dismiss,
          ),
        );
        break;
      case LoginStatus.loginErrorUnsuccessful:
        emit(
          const LoginFailureState(
            message: LocalizationConstants.IncorrectLoginOrPassword,
            buttonText: LocalizationConstants.Dismiss,
          ),
        );
        break;
      case LoginStatus.loginErrorUnknown:
        emit(
          const LoginFailureState(
            message: LocalizationConstants.UnableToGetCurrentSession,
            buttonText: LocalizationConstants.Dismiss,
          ),
        );
        break;
    }
  }
}
