import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/billing_shipping_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/scanning_mode.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/promo_code_cubit/promo_code_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/base_checkout.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/checkout_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/checkout_success_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/payment_details/checkout_payment_details.dart';
import 'package:commerce_flutter_app/features/presentation/widget/product_list_with_basicInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VmiCheckoutEntity {
  final Cart cart;
  final ScanningMode scanningMode;

  VmiCheckoutEntity(this.cart, this.scanningMode);
}

class VmiCheckoutScreen extends StatelessWidget {
  final VmiCheckoutEntity vmiCheckoutEntity;

  const VmiCheckoutScreen({super.key, required this.vmiCheckoutEntity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckoutBloc>(
            create: (context) => sl<CheckoutBloc>()
              ..add(LoadCheckoutEvent(cart: vmiCheckoutEntity.cart))),
        BlocProvider<TokenExBloc>(create: (context) => sl<TokenExBloc>()),
        BlocProvider<PromoCodeCubit>(create: (context) => sl<PromoCodeCubit>()),
        BlocProvider<ReviewOrderCubit>(
            create: (context) => sl<ReviewOrderCubit>()),
        BlocProvider<PaymentDetailsBloc>(
          create: (context) => sl<PaymentDetailsBloc>()
            ..add(LoadPaymentDetailsEvent(cart: vmiCheckoutEntity.cart)),
        ),
      ],
      child: VmiCheckoutPage(scanningMode: vmiCheckoutEntity.scanningMode),
    );
  }
}

class VmiCheckoutPage extends StatelessWidget with BaseCheckout {
  final ScanningMode scanningMode;

  VmiCheckoutPage({super.key, required this.scanningMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (_, state) {
          if (state is CheckoutPlaceOrder) {
            AppRoute.checkoutSuccess.navigate(context,
                extra: CheckoutSuccessEntity(
                    orderNumber: state.orderNumber,
                    reviewOrderEntity: state.reviewOrderEntity,
                    isVmiCheckout: true,
                    cart: context.read<CheckoutBloc>().cart!));
          } else if (state is CheckoutPlaceOrderFailed) {
            _showAlert(context, message: LocalizationConstants.orderFailed);
          }
        },
        buildWhen: (previous, current) =>
            current is CheckoutInitial ||
            current is CheckoutLoading ||
            current is CheckoutDataLoaded,
        builder: (_, state) {
          return BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (_, state) {
              switch (state) {
                case CheckoutInitial():
                case CheckoutLoading():
                  return const Center(child: CircularProgressIndicator());
                case CheckoutDataLoaded():
                  final billingShippingEntity = BillingShippingEntity(
                    billTo: state.billToAddress,
                    shipTo: state.shipToAddress,
                    warehouse: state.wareHouse,
                    shippingMethod: (state.shippingMethod
                            .equalsIgnoreCase(ShippingOption.pickUp.name)
                        ? ShippingOption.pickUp
                        : ShippingOption.ship),
                    carriers: state.cart.carriers,
                    cartSettings: state.cartSettings,
                    selectedCarrier: state.selectedCarrier,
                    selectedService: state.selectedService,
                    requestDeliveryDate: state.requestDeliveryDate,
                  );

                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                buildSummary(state.cart, state.promotions),
                                BillingShippingWidget(
                                    billingShippingEntity:
                                        billingShippingEntity),
                                CheckoutPaymentDetails(
                                    cart: context.read<CheckoutBloc>().cart!,
                                    onCompleteCheckoutPaymentSection: () {
                                      context.read<CheckoutBloc>().add(
                                          SelectPaymentEvent(context
                                              .read<PaymentDetailsBloc>()
                                              .cart!
                                              .paymentOptions!));
                                      // context
                                      //     .read<ExpansionPanelCubit>()
                                      //     .onContinueClick();
                                    }),
                                buildOrderNote(),
                                const SizedBox(height: 8),
                                ProductListWithBasicInfo(
                                  totalItemsTitle:
                                      LocalizationConstants.cartContentsItems,
                                  list: CartLineListMapper()
                                          .toEntity(CartLineList(
                                              cartLines:
                                                  state.cart.cartLines ?? []))
                                          .cartLines ??
                                      [],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Column(
                            children: [
                              TertiaryButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(scanningMode == ScanningMode.count
                                    ? LocalizationConstants.backToCountInventory
                                    : LocalizationConstants.backToCreateOrder),
                              ),
                              const SizedBox(height: 4.0),
                              PrimaryButton(
                                onPressed: () {
                                  _handleSubmitOrderClick(context, state);
                                },
                                text: LocalizationConstants.submitOrder,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                default:
                  return const Center();
              }
            },
          );
        },
      ),
    );
  }

  void _handleSubmitOrderClick(BuildContext context, CheckoutDataLoaded state) {
    var isPaymentCardType =
        context.read<PaymentDetailsBloc>().selectedPaymentMethod?.cardType !=
            null;
    var isCreditCardSectionCompleted =
        context.read<PaymentDetailsBloc>().isCreditCardSectionCompleted;

    if (isPaymentCardType && !isCreditCardSectionCompleted) {
      context.read<TokenExBloc>().add(TokenExValidateEvent());
    } else {
      var poNumber = context.read<PaymentDetailsBloc>().getPONumber();
      var cart = context.read<PaymentDetailsBloc>().cart;

      if (cart!.requiresPoNumber! && poNumber.isNullOrEmpty) {
        CustomSnackBar.showPoNumberRequired(context);
      } else {
        context.read<CheckoutBloc>().add(UpdatePONumberEvent(poNumber));
        context.read<CheckoutBloc>().add(PlaceOrderEvent(
            reviewOrderEntity: prepareReviewOrderEntiity(state, context)));
      }
    }
  }

  void _showAlert(BuildContext context, {String? title, String? message}) {
    displayDialogWidget(
        context: context,
        title: title,
        message: message,
        actions: [
          DialogPlainButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(LocalizationConstants.oK),
          ),
        ]);
  }

}
