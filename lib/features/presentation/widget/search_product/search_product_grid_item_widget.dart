import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_to_cart/add_to_cart_state.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_pricing_widgert.dart';
import 'package:commerce_flutter_app/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchProductGridItemWidget extends StatelessWidget {
  final ProductEntity product;
  final ProductSettings? productSettings;
  final bool? pricingEnable;
  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;
  final bool? canAddToCartInProductList;

  const SearchProductGridItemWidget({
    super.key,
    required this.product,
    required this.productSettings,
    required this.pricingEnable,
    this.hidePricingEnable,
    this.hideInventoryEnable,
    this.canAddToCartInProductList,
  });

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / 2;
    double imageItemLength = itemWidth; // subtract horizontal padding

    return InkWell(
      onTap: () {
        var productId = product.styleParentId ?? product.id;
        //TODO what if productid is null,
        AppRoute.topLevelProductDetails.navigateBackStack(context,
            pathParameters: {"productId": productId.toString()},
            extra: product);
      },
      child: Container(
        width: itemWidth,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Column(
          children: [
            SizedBox(
              width: imageItemLength,
              height: imageItemLength - 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: const Color(0xFFD6D6D6)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Image.network(
                        product.smallImagePath.makeImageUrl(),
                        fit: BoxFit.cover,
                        width: double
                            .infinity, // Ensure the image covers the entire container
                        height: double.infinity,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Container(
                            color: OptiAppColors
                                .backgroundGray, // Placeholder color
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.image, // Icon to display
                              color: Colors.grey, // Icon color
                              size: 30, // Icon size
                            ),
                          );
                        },
                      ),
                      if (canAddToCartInProductList == true) ...{
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: BlocProvider<AddToCartCubit>(
                            create: (context) => sl<AddToCartCubit>()
                              ..updateAddToCartButton(product),
                            child: BlocListener<AddToCartCubit, AddToCartState>(
                              listener: (context, state) {
                                if (state is AddToCartSuccess) {
                                  context
                                      .read<CartCountCubit>()
                                      .onCartItemChange();
                                  CustomSnackBar.showProductAddedToCart(
                                      context);
                                }
                              },
                              child:
                                  BlocBuilder<AddToCartCubit, AddToCartState>(
                                buildWhen: (previous, current) =>
                                    current is AddToCartEnable &&
                                    previous is AddToCartButtonLoading,
                                builder: (context, state) {
                                  if (state is AddToCartInitial) {
                                    return Container();
                                  } else if (state is AddToCartButtonLoading) {
                                    return Container(
                                      alignment: Alignment.bottomLeft,
                                      child: LoadingAnimationWidget
                                          .prograssiveDots(
                                        color: OptiAppColors.iconPrimary,
                                        size: 30,
                                      ),
                                    );
                                  } else if (state is AddToCartEnable) {
                                    if (state.canAddToCart) {
                                      return IconButton(
                                        onPressed: () {
                                          var productId =
                                              product.styleParentId ??
                                                  product.id;
                                          context
                                              .read<AddToCartCubit>()
                                              .searchPorductAddToCard(
                                                  productId!);
                                        },
                                        icon: Container(
                                          width: 40,
                                          height: 40,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color:
                                                OptiAppColors.backgroundInput,
                                            borderRadius:
                                                BorderRadius.circular(32),
                                          ),
                                          child: const SvgAssetImage(
                                            assetName: AssetConstants.addToCart,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                  return Container();
                                },
                              ),
                            ),
                          ),
                        ),
                      }
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        product.shortDescription ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: OptiTextStyles.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        LocalizationConstants.itemNumber
                            .localized()
                            .format([product.erpNumber ?? '']),
                        style: OptiTextStyles.bodySmall.copyWith(
                          color: OptiAppColors.textDisabledColor,
                        ),
                      ),
                      _getInfoWidget(),
                      const SizedBox(height: 4),
                      LineItemPricingWidget(
                        discountMessage: product.pricing?.getDiscountValue(),
                        priceValueText:
                            product.updatePriceValueText(pricingEnable),
                        unitOfMeasureValueText:
                            product.updateUnitOfMeasure(pricingEnable),
                        availabilityText: product.availability?.message,
                        availabilityMessageType:
                            product.availability?.messageType,
                        productId: product.id,
                        erpNumber: product.erpNumber,
                        unitOfMeasure: product.unitOfMeasure,
                        showViewAvailabilityByWarehouse:
                            _showWarehouseInventory(),
                        hidePricingEnable: hidePricingEnable,
                        hideInventoryEnable: hideInventoryEnable,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getInfoWidget() {
    List<Widget> list = [];

    final myPart = _buildRow(
        LocalizationConstants.myPartNumberSign.localized(),
        OptiTextStyles.bodySmall,
        product.customerName ?? '',
        OptiTextStyles.bodyExtraSmall);
    final mfg = _buildRow(
        LocalizationConstants.mFGNumberSign.localized(),
        OptiTextStyles.bodySmall,
        product.manufacturerItem ?? '',
        OptiTextStyles.bodyExtraSmall);

    final pack = _buildRow(
        LocalizationConstants.packSign.localized(),
        OptiTextStyles.bodySmall,
        product.packDescription ?? '',
        OptiTextStyles.bodyExtraSmall);

    if (myPart != null) {
      list.add(myPart);
    }
    if (mfg != null) {
      list.add(mfg);
    }
    if (pack != null) {
      list.add(pack);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget? _buildRow(String title, TextStyle titleTextStyle, String body,
      TextStyle bodyTextStyle) {
    if (title.isEmpty || body.isEmpty) {
      return null;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: titleTextStyle,
          ),
        ),
        Text(
          body,
          textAlign: TextAlign.start,
          style: bodyTextStyle,
        )
      ],
    );
  }

  bool _showWarehouseInventory() {
    var warehouseInventoryButtonEnabled =
        InventoryUtils.isInventoryPerWarehouseButtonShownAsync(productSettings);
    var showWarehouseInventoryButton = false;

    if (!(product.isConfigured ?? false) ||
        (product.isFixedConfiguration ?? false) &&
            !(product.isStyleProductParent ?? false)) {
      if (product.availability != null &&
          !(product.availability?.requiresRealTimeInventory ?? false) &&
          (product.availability?.messageType ?? 0) != 0) {
        showWarehouseInventoryButton = (product.trackInventory ?? false) &&
            warehouseInventoryButtonEnabled;
      }
    }

    return showWarehouseInventoryButton;
  }
}
