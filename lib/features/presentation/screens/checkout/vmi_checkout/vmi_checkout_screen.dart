import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/billing_shipping_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/base_checkout.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/payment_details/checkout_payment_details.dart';
import 'package:commerce_flutter_app/features/presentation/widget/product_list_with_basicInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VmiCheckoutScreen extends StatelessWidget {

  final Cart cart;

  const VmiCheckoutScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckoutBloc>(
            create: (context) =>
            sl<CheckoutBloc>()..add(LoadCheckoutEvent(cart: cart))),
        BlocProvider<TokenExBloc>(create: (context) => sl<TokenExBloc>()),
        BlocProvider<ReviewOrderCubit>(
            create: (context) => sl<ReviewOrderCubit>()),
        BlocProvider<PaymentDetailsBloc>(
          create: (context) => sl<PaymentDetailsBloc>()
            ..add(LoadPaymentDetailsEvent(cart: cart)),
        ),
      ],
      child: VmiCheckoutPage(),
    );
  }

}

class VmiCheckoutPage extends StatelessWidget with BaseCheckout {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (_, state) {
          if (state is CheckoutPlaceOrder) {
            AppRoute.checkoutSuccess
                .navigate(context, extra: state.orderNumber);
          }
        },
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

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Expanded(child: Column(
                          children: [
                            buildSummary(state.cart, state.promotions),
                            BillingShippingWidget(
                                billingShippingEntity: billingShippingEntity),
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
                              totalItemsTitle: LocalizationConstants.cartContentsItems,
                              list: CartLineListMapper()
                                  .toEntity(CartLineList(cartLines: state.cart.cartLines ?? [])).cartLines ?? [],
                            ),
                          ],
                        )),
                        Container(
                          height: 160,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Column(
                            children: [
                              PrimaryButton(
                                onPressed: () {

                                },
                                text: LocalizationConstants.backToCountInventory,
                              ),
                              const SizedBox(height: 4.0),
                              PrimaryButton(
                                onPressed: () {

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

}