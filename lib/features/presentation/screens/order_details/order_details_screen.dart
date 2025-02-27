import 'dart:async';

import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/bottom_menu_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_details/order_details_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/order_details_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderNumber;
  final bool? isFromVMI;
  const OrderDetailsScreen({
    super.key,
    required this.orderNumber,
    required this.isFromVMI,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = sl<OrderDetailsCubit>();
            unawaited(
              cubit.loadOrderDetails(orderNumber, isFromVMI: isFromVMI),
            );
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) => sl<BottomMenuCubit>(), // for print path
        ),
      ],
      child: Builder(builder: (context) {
        return BlocListener<BottomMenuCubit, BottomMenuState>(
          // for determining the print path
          listener: (context, state) {
            switch (state) {
              case BottomMenuWebsiteUrlLoaded():
                unawaited(launchUrlString(state.url));
              case BottomMenuWebsiteUrlFailed():
                displayDialogWidget(
                  context: context,
                  title: LocalizationConstants.error.localized(),
                  message: state.message,
                  actions: [
                    DialogPlainButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(LocalizationConstants.oK.localized()),
                    ),
                  ],
                );
            }
          },
          child: const OrderDetailsPage(),
        );
      }),
    );
  }
}

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        centerTitle: false,
        actions: const [
          _OptionsMenu(),
        ],
        title: context.watch<OrderDetailsCubit>().state.orderStatus ==
                OrderStatus.success
            ? Text(context.watch<OrderDetailsCubit>().orderNumber ?? '')
            : Text(LocalizationConstants.orderDetails.localized()),
      ),
      body: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
        listener: (context, state) async {
          if (state.orderStatus == OrderStatus.reorderLoading) {
            showPleaseWait(context);
          }

          if (state.orderStatus == OrderStatus.reorderSuccess) {
            Navigator.of(context, rootNavigator: true).pop();
            unawaited(context.read<CartCountCubit>().onCartItemChange());
            CustomSnackBar.showSnackBarMessage(
              context,
              state.errorMessage ?? '',
            );
          }

          if (state.orderStatus == OrderStatus.reorderFailure) {
            Navigator.of(context, rootNavigator: true).pop();
            CustomSnackBar.showSnackBarMessage(
              context,
              state.errorMessage ?? '',
            );
          }
        },
        builder: (context, state) {
          if (state.orderStatus == OrderStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.orderStatus == OrderStatus.failure) {
            return const Center(
              child: Text('Failed to load order details'),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        OrderDetailsBodyWidget(
                          orderNumber:
                              context.watch<OrderDetailsCubit>().orderNumber,
                          orderDate:
                              context.watch<OrderDetailsCubit>().orderDate,
                          poNumber: context.watch<OrderDetailsCubit>().poNumber,
                          orderStatus:
                              context.watch<OrderDetailsCubit>().orderStatus,
                          shippingMethod:
                              context.watch<OrderDetailsCubit>().shippingMethod,
                          terms: context.watch<OrderDetailsCubit>().terms,
                          requestedDeliveryDate: context
                              .watch<OrderDetailsCubit>()
                              .requestedDeliveryDate,
                          requestedDeliveryDateTitle: context
                              .watch<OrderDetailsCubit>()
                              .requestedDeliveryDateTitle,
                          webOrderNumber:
                              context.watch<OrderDetailsCubit>().webOrderNumber,
                          shippingCompanyName: context
                              .watch<OrderDetailsCubit>()
                              .shippingCompanyName,
                          shippingFullAddress: context
                              .watch<OrderDetailsCubit>()
                              .shippingFullAddress,
                          shippingCountryName: context
                              .watch<OrderDetailsCubit>()
                              .shippingCountryName,
                          isShippingAddressVisible: context
                              .watch<OrderDetailsCubit>()
                              .isShippingAddressVisible,
                          billingCompanyName: context
                              .watch<OrderDetailsCubit>()
                              .billingCompanyName,
                          billingFullAddress: context
                              .watch<OrderDetailsCubit>()
                              .billingFullAddress,
                          isPickupLocationVisible: context
                              .watch<OrderDetailsCubit>()
                              .isPickupLocationVisible,
                          pickupLocationAddress: context
                              .watch<OrderDetailsCubit>()
                              .pickupLocationAddress,
                          discount:
                              context.watch<OrderDetailsCubit>().discountValue,
                          discountTitle:
                              context.watch<OrderDetailsCubit>().discountTitle,
                          otherCharges: context
                              .watch<OrderDetailsCubit>()
                              .otherChargesValue,
                          otherChargesTitle: context
                              .watch<OrderDetailsCubit>()
                              .otherChargesTitle,
                          shippingHandling: context
                              .watch<OrderDetailsCubit>()
                              .shippingHandlingValue,
                          shippingHandlingTitle: context
                              .watch<OrderDetailsCubit>()
                              .shippingHandlingTitle,
                          subtotal:
                              context.watch<OrderDetailsCubit>().subTotalValue,
                          subtotalTitle:
                              context.watch<OrderDetailsCubit>().subTotalTitle,
                          tax: context.watch<OrderDetailsCubit>().taxValue,
                          taxTitle: context.watch<OrderDetailsCubit>().taxTitle,
                          total: context.watch<OrderDetailsCubit>().totalValue,
                          totalTitle:
                              context.watch<OrderDetailsCubit>().totalTitle,
                          itemCount: state.order.orderLines?.length,
                          hidePricingEnable: state.hidePricingEnable,
                          hideInventoryEnable: state.hideInventoryEnable,
                        ),
                        OrderProductsSectionWidget(
                          orderLines: state.order.orderLines ?? [],
                          hidePricingEnable: state.hidePricingEnable,
                          hideInventoryEnable: state.hideInventoryEnable,
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.isReorderViewVisible)
                  OrderBottomSectionWidget(
                    actions: [
                      PrimaryButton(
                        text: LocalizationConstants.reorder.localized(),
                        onPressed: () {
                          context.read<RootBloc>().add(
                                RootAnalyticsEvent(
                                  context
                                      .read<OrderDetailsCubit>()
                                      .currentOrderAnalyticEvent(
                                        AnalyticsEvent(
                                          AnalyticsConstants.eventSelectReorder,
                                          AnalyticsConstants
                                              .screenNameOrderDetail,
                                        ),
                                      ),
                                ),
                              );
                          confirmDialog(
                            context: context,
                            onConfirm: () {
                              unawaited(
                                context
                                    .read<OrderDetailsCubit>()
                                    .reorderAllProducts(),
                              );
                            },
                            onCancel: () {
                              context.read<RootBloc>().add(
                                    RootAnalyticsEvent(
                                      context
                                          .read<OrderDetailsCubit>()
                                          .currentOrderAnalyticEvent(
                                            AnalyticsEvent(
                                              AnalyticsConstants
                                                  .eventCancelReorder,
                                              AnalyticsConstants
                                                  .screenNameOrderDetail,
                                            ),
                                          ),
                                    ),
                                  );
                            },
                            message: LocalizationConstants.addOrderContentToCart
                                .localized(),
                            confirmText:
                                LocalizationConstants.reorder.localized(),
                          );
                        },
                      ),
                    ],
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _OptionsMenu extends StatelessWidget {
  const _OptionsMenu();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
      builder: (context, state) {
        var websitePathOrderNumber = state.order.webOrderNumber.isNullOrEmpty
            ? state.order.erpOrderNumber
            : state.order.webOrderNumber;
        String? websitePath = websitePathOrderNumber.isNullOrEmpty
            ? ''
            : 'redirectto/OrderDetailPage?ordernumber=${websitePathOrderNumber ?? ''}';
        var printPath = PrintPaths.orderDetailPrintPath.format(
          [
            websitePathOrderNumber ?? '',
            state.order.shipToPostalCode ?? '',
          ],
        );

        return BottomMenuWidget(
          websitePath: websitePath,
          screenName: AnalyticsConstants.screenNameOrderDetail,
          toolMenuList: [
            ToolMenu(
              title: LocalizationConstants.print.localized(),
              action: () {
                unawaited(
                  context.read<BottomMenuCubit>().loadWebsiteUrl(
                        printPath,
                      ),
                );
                context.read<RootBloc>().add(
                      RootAnalyticsEvent(
                        AnalyticsEvent(
                          AnalyticsConstants.eventPrintPdf,
                          AnalyticsConstants.screenNameOrderDetail,
                        ).withProperty(
                          name: AnalyticsConstants.eventPropertyUrl,
                          strValue: printPath,
                        ),
                      ),
                    );
              },
            ),
          ],
        );
      },
    );
  }
}
