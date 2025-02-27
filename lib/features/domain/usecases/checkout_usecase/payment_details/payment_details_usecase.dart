import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PaymentDetailsUseCase extends BaseUseCase {
  PaymentDetailsUseCase() : super();

  Future<Result<Cart, ErrorResponse>> getCurrentCart() async {
    var cartParameters = CartQueryParameters(expand: ['paymentoptions']);

    return commerceAPIServiceProvider
        .getCartService()
        .getCurrentCart(cartParameters);
  }

  Future<Result<AccountPaymentProfileCollectionResult, ErrorResponse>>
      getPaymentProfileData(PaymentProfileQueryParameters parameters) async {
    return await commerceAPIServiceProvider
        .getAccountService()
        .getPaymentProfiles(parameters: parameters);
  }

  Future<Result<TokenExDto, ErrorResponse>> getTokenExConfiguration(
      String token) async {
    return await coreServiceProvider
        .getAppConfigurationService()
        .getTokenExConfiguration(token);
  }

  String? get tokenExIFrameUrl {
    var url = coreServiceProvider.getAppConfigurationService().tokenExIFrameUrl;
    return url;
  }

  bool get shouldShowOrderNotes {
    return !(coreServiceProvider
            .getAppConfigurationService()
            .baseConfig
            ?.customHideCheckoutOrderNotes ??
        false);
  }
}
