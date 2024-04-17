import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/produc_details_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ProductDetailsUseCase _productDetailsUseCase;



  ProductDetailsBloc({required ProductDetailsUseCase productDetailsUseCase})
      : _productDetailsUseCase = productDetailsUseCase,
        super(ProductDetailsInitial()) {
    on<FetchProductDetailsEvent>(_fetchProductDetails);
  }
          // var getCurrentAccountSettingsTask = this.commerceAPIServiceProvider.GetSettingsService().GetAccountSettingsAsync();
          //   var getCurrentSessionTask = this.commerceAPIServiceProvider.GetSessionService().GetCurrentSession();
          //   var getAddToCartEnabledResultTask = this.coreServiceProvider.GetAppConfigurationService().AddToCartEnabled();
          //   var getProductPricingEnabledResultTask = this.coreServiceProvider.GetAppConfigurationService().ProductPricingEnabled();
          //   var getCurrentRealtimeSupportTask = this.coreServiceProvider.GetAppConfigurationService().GetRealtimeSupportType();
          //   var hasCheckoutTask = this.coreServiceProvider.GetAppConfigurationService().HasCheckout();

  Future<void> _loadSetting() async {
    var productSettingsResult = await _productDetailsUseCase.loadSetting();



  }

  Future<void> _fetchProductDetails(
      FetchProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoading());

    final result = await _productDetailsUseCase.getProductDetails(
        event.productId, event.product);

    switch (result) {
      case Success(value: final data):
        _makeAllDetailsItems(data!, emit);
      case Failure(errorResponse: final errorResponse):
        emit(ProductDetailsErrorState(errorResponse.errorDescription ?? ''));
    }
  }

  Future<void> _makeAllDetailsItems(
      ProductEntity productData, Emitter<ProductDetailsState> emit) async {
    final productDetailsEntotities =
        _productDetailsUseCase.makeAllDetailsItems(productData);
    emit(
        ProductDetailsLoaded(productDetailsEntities: productDetailsEntotities));
  }
}
