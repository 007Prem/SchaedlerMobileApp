import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenExBloc extends Bloc<TokenExEvent, TokenExState> {
  bool isTokenExConfigurationSet = false;
  TokenExBloc() : super(TokenExInitial()) {
    on<LoadTokenExFieldEvent>((event, emit) => _setUpTokenExField(event, emit));
    on<HandleTokenExEvent>((event, emit) => _handleWebViewRequest(event, emit));
    on<TokenExCongigurationSetEvent>((event, emit) {
      _setTokenExconfiguration(event.isConfigurationSet);
    });
    on<TokenExValidateEvent>((event, emit) {
      emit(TokenExValidateState());
    });
  }

  void _setTokenExconfiguration(bool isConfigurationSet) {
    isTokenExConfigurationSet = isConfigurationSet;
  }

  Future<void> _setUpTokenExField(
      LoadTokenExFieldEvent event, Emitter<TokenExState> emit) async {
    emit(TokenExLoading());
    var tokenExEntity = event.tokenExEntity;
    emit(TokenExLoaded(tokenExEntity: tokenExEntity));
  }

  Future<void> _handleWebViewRequest(
      HandleTokenExEvent event, Emitter<TokenExState> emit) async {
    var urlString = event.urlString;
    var uri = Uri.parse(urlString);
    var query = uri.queryParameters;

    if (urlString.endsWith("loaded")) {
      return;
    }

    if (urlString.endsWith("error")) {
      // tokenExLoadFailedCallback?.call(true);
      return;
    }

    var valid = query["valid"];
    if (valid == null) {
      return;
    }

    var isValid = valid.toLowerCase() == 'true';
    if (query.isNotEmpty) {
      var encodedCreditCardNumber = query["cardNumber"];
      var encodedCVVCode = query["securityCode"];
      var encodedType = query["type"];
      if (encodedCVVCode != null &&
          encodedCreditCardNumber != null &&
          encodedType != null) {
        print("TokenExEncodingFinishedState");
        emit(TokenExEncodingFinishedState(
            cardNumber: encodedCreditCardNumber,
            securityCode: encodedCVVCode,
            cardType: encodedType));

        return;
      }
    }
    if (isValid) {
      emit(TokenExEncodeState());
    } else {
      // tokenExValidateCallback?.call(false);
      return;
    }
  }
}
