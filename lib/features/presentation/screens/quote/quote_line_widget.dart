import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/cart_line_extentions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_image_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_pricing_widgert.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_quantity_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuoteLineWidget extends StatelessWidget {
  final QuoteLineEntity quoteLineEntity;
  final bool? showRemoveButton;
  final Widget? moreButtonWidget;
  final void Function()? onShowMoreButtonClickedCallback;
  final void Function(int quantity) onCartQuantityChangedCallback;
  final void Function(CartLineEntity) onCartLineRemovedCallback;
  const QuoteLineWidget(
      {super.key,
      required this.quoteLineEntity,
      required this.onCartQuantityChangedCallback,
      required this.onCartLineRemovedCallback,
      this.onShowMoreButtonClickedCallback,
      this.showRemoveButton = true,
      this.moreButtonWidget});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToProductDetails(context),
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            _buildProductDetails(context),
            Visibility(
                visible: showRemoveButton!, child: _buildRemoveButton(context)),
            Visibility(
                visible: moreButtonWidget != null,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: moreButtonWidget ?? Container(),
                ))
          ],
        ),
      ),
    );
  }

  void _navigateToProductDetails(BuildContext context) {
    var productId = quoteLineEntity.productId;
    AppRoute.productDetails.navigateBackStack(context,
        pathParameters: {"productId": productId.toString()},
        extra: ProductEntity());
  }

  Widget _buildProductImage() {
    return LineItemImageWidget(imagePath: quoteLineEntity.smallImagePath ?? "");
  }

  Widget _buildProductDetails(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LineItemTitleWidget(
            shortDescription: quoteLineEntity.shortDescription,
            manufacturerItem: quoteLineEntity.manufacturerItem,
            productNumber: quoteLineEntity.getProductNumber(),
          ),
          LineItemPricingWidget(
              discountMessage: quoteLineEntity.pricing?.getDiscountValue(),
              priceValueText: quoteLineEntity.updatePriceValueText(),
              unitOfMeasureValueText:
                  quoteLineEntity.updateUnitOfMeasureValueText(),
              availabilityText: quoteLineEntity.availability?.message,
              productId: quoteLineEntity.productId,
              erpNumber: quoteLineEntity.erpNumber,
              unitOfMeasure: quoteLineEntity.baseUnitOfMeasure,
              showViewAvailabilityByWarehouse:
                  quoteLineEntity.showInventoryAvailability ?? false),
          LineItemQuantityGroupWidget(
            qtyOrdered: quoteLineEntity.qtyOrdered?.toInt().toString(),
            onQtyChanged: (int? qty) {
              if (qty == null) {
                return;
              }

              onCartQuantityChangedCallback(qty);
            },
            subtotalPriceText: quoteLineEntity.updateSubtotalPriceValueText(),
          ),
        ],
      ),
    );
  }

  Widget _buildRemoveButton(BuildContext context) {
    return InkWell(
      onTap: () {
        onCartLineRemovedCallback(quoteLineEntity);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          width: 30,
          height: 30,
          child: SvgPicture.asset(
            AssetConstants.cartItemRemoveIcon,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
