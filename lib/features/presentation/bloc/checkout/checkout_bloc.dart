import 'package:commerce_flutter_app/features/domain/entity/checkout/review_order_entity.dart';
import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/usecases/checkout_usecase/checkout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'checkout_state.dart';
part 'checkout_event.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutUsecase _checkoutUseCase;
  DateTime? requestDeliveryDate;
  Cart? cart;
  CarrierDto? selectedCarrier;
  ShipViaDto? selectedService;
  PaymentOptionsDto? selectedPayment;
  Session? session;

  CheckoutBloc({required CheckoutUsecase checkoutUsecase})
      : _checkoutUseCase = checkoutUsecase,
        super(CheckoutInitial()) {
    on<LoadCheckoutEvent>((event, emit) => _onCheckoutLoadEvent(event, emit));
    on<PlaceOrderEvent>((event, emit) => _onPlaceOrderEvent(event, emit));
    on<RequestDeliveryDateEvent>(
        (event, emit) => _onRequestDeliveryDateSelect(event, emit));
    on<SelectCarrierEvent>((event, emit) => _onCarrierSelect(event, emit));
    on<SelectServiceEvent>((event, emit) => _onServiceSelect(event, emit));
    on<SelectPaymentMethodEvent>(
        (event, emit) => _onPaymentMethodSelect(event, emit));
    on<SelectPaymentEvent>((event, emit) => _onPaymentSelect(event, emit));
    on<UpdatePONumberEvent>((event, emit) => _onUpdatePONumber(event, emit));
    on<UpdateShiptoAddressEvent>((event, emit) => _onUpdateShipTo(event, emit));
  }

  void updateCheckoutData(Cart cart) {
    this.cart = cart;
    selectedCarrier = cart.carrier;
    selectedService = cart.shipVia;
  }

  Future<void> _onCheckoutLoadEvent(
      LoadCheckoutEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    var data = await _checkoutUseCase.getCart(event.cart.id!);
    session ??= _checkoutUseCase.getCurrentSession();

    switch (data) {
      case Success(value: final cartData):
        updateCheckoutData(cartData!);

        final billToAddress = session?.billTo;
        final shipToAddress = session?.shipTo;
        final wareHouse = session?.pickUpWarehouse;
        var shippingMethod = session?.fulfillmentMethod;
        PromotionCollectionModel? promotionCollection =
            (await _checkoutUseCase.loadCartPromotions())
                .getResultSuccessValue();
        CartSettings? cartSettings =
            (await _checkoutUseCase.getCartSetting()).getResultSuccessValue();

        if (billToAddress != null &&
            shipToAddress != null &&
            wareHouse != null &&
            shippingMethod != null) {
          emit(CheckoutDataLoaded(
            cart: cartData,
            billToAddress: billToAddress,
            shipToAddress: shipToAddress,
            wareHouse: wareHouse,
            promotions: promotionCollection,
            shippingMethod: shippingMethod,
            cartSettings: cartSettings,
            selectedCarrier: selectedCarrier,
            selectedService: selectedService,
            requestDeliveryDate: requestDeliveryDate,
          ));
        } else {
          emit(CheckoutDataFetchFailed(
              error:
                  'BillTo: $billToAddress, ShipTo: $shipToAddress, WareHouse: ${wareHouse?.toJson()}, ShippingMethod: $shippingMethod'));
        }
        break;
      case Failure(errorResponse: final errorResponse):
        emit(CheckoutDataFetchFailed(
            error: errorResponse.errorDescription ?? ''));
        break;
    }
  }

  Future<void> _onPlaceOrderEvent(
      PlaceOrderEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    cart?.status =
        (cart?.requiresApproval ?? false) ? 'AwaitingApproval' : 'Submitted';

    final result = await _checkoutUseCase.patchCart(cart!);
    switch (result) {
      case Success(value: final cartData):
        String orderNumber = ((cartData?.erpOrderNumber != null &&
                    cartData!.erpOrderNumber!.isNotEmpty)
                ? cartData.erpOrderNumber
                : cartData?.orderNumber) ??
            '';

        emit(CheckoutPlaceOrder(
            orderNumber: orderNumber,
            reviewOrderEntity: event.reviewOrderEntity,
            cart: cartData!));

        break;
      case Failure(errorResponse: final errorResponse):
        emit(CheckoutDataFetchFailed(
            error: errorResponse.errorDescription ?? ''));
        break;
    }
  }

  void _onRequestDeliveryDateSelect(
      RequestDeliveryDateEvent event, Emitter<CheckoutState> emit) {
    requestDeliveryDate = event.dateTime;
    cart?.requestedDeliveryDate = event.dateTime.toIso8601String();
  }

  Future<void> _onCarrierSelect(
      SelectCarrierEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    selectedCarrier = event.carrier;
    selectedService = event.carrier.shipVias?.first;
    cart?.carrier = selectedCarrier;
    cart?.shipVia = selectedService;
    await _checkoutUseCase.patchCart(cart!);
    add(LoadCheckoutEvent(cart: cart!));
  }

  Future<void> _onServiceSelect(
      SelectServiceEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    selectedService = event.service;
    cart?.shipVia = selectedService;
    await _checkoutUseCase.patchCart(cart!);
    add(LoadCheckoutEvent(cart: cart!));
  }

  Future<void> _onPaymentMethodSelect(
      SelectPaymentMethodEvent event, Emitter<CheckoutState> emit) async {
    cart?.paymentMethod = event.paymentMethod;
  }

  Future<void> _onPaymentSelect(
      SelectPaymentEvent event, Emitter<CheckoutState> emit) async {
    // selectedPayment = event.paymentOption;
    cart?.paymentOptions?.creditCard?.cardHolderName =
        selectedPayment?.creditCard?.cardHolderName;
    cart?.paymentOptions?.creditCard?.cardNumber =
        selectedPayment?.creditCard?.cardNumber;
    cart?.paymentOptions?.creditCard?.cardType =
        selectedPayment?.creditCard?.cardType;
    cart?.paymentOptions?.creditCard?.expirationMonth =
        selectedPayment?.creditCard?.expirationMonth;
    cart?.paymentOptions?.creditCard?.expirationYear =
        selectedPayment?.creditCard?.expirationYear;
  }

  void _onUpdatePONumber(
      UpdatePONumberEvent event, Emitter<CheckoutState> emit) {
    cart?.poNumber = event.poNumber;
  }

  Future<void> _onUpdateShipTo(
      UpdateShiptoAddressEvent event, Emitter<CheckoutState> emit) async {
    var response =
        await _checkoutUseCase.postCurrentBillToShipToAsync(event.shipTo);

    cart?.shipTo = response is Success
        ? (response as Success).value as ShipTo
        : event.shipTo;

    session?.shipTo = cart?.shipTo;
    emit(CheckoutShipToAddressAddedState());
  }
}
