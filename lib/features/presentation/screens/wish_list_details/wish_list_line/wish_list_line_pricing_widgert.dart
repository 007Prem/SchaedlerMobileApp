import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/wish_list_line_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';

import 'package:flutter/material.dart';

class WishListContentPricingWidget extends StatelessWidget {
  final WishListLineEntity wishListLineEntity;

  const WishListContentPricingWidget({
    required this.wishListLineEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDiscountMessageSection(context, wishListLineEntity),
              _buildPricingSection(context, wishListLineEntity),
              GestureDetector(
                onTap: () {
                  // TODO: Implement the logic for "View Quantity Pricing"
                  CustomSnackBar.showComingSoonSnackBar(context);
                },
                child: Text(
                  "View Quantity Pricing",
                  style: OptiTextStyles.link,
                ),
              ),
              wishListLineEntity.availability?.message != null
                  ? _buildInventorySection(context, wishListLineEntity)
                  : Container(),
              // _buildInventorySection(context),
              // For "View Availability by Warehouse"
              GestureDetector(
                onTap: () {
                  // TODO: Implement the logic for "View Quantity Pricing"
                  CustomSnackBar.showComingSoonSnackBar(context);
                },
                child: Text(
                  "View Availability by Warehouse",
                  style: OptiTextStyles.link,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDiscountMessageSection(
    BuildContext context, WishListLineEntity wishListLineEntity) {
  var discountMessage = wishListLineEntity.pricing?.getDiscountValue();
  if (discountMessage != null &&
      discountMessage.isNotEmpty &&
      discountMessage != "null") {
    return Text(
      discountMessage,
      style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.italic,
          color: OptiAppColors.textSecondary),
    );
  }
  return Container();
}

Widget _buildPricingSection(
    BuildContext context, WishListLineEntity wishListLineEntity) {
  return Row(
    children: [
      Text(wishListLineEntity.updatePriceValueText,
          style: OptiTextStyles.bodySmallHighlight),
      Text(
        wishListLineEntity.updateUnitOfMeasureValueText,
        style: OptiTextStyles.bodySmall,
      ),
    ],
  );
}

Widget _buildInventorySection(
    BuildContext context, WishListLineEntity wishListLineEntity) {
  return Text(
    wishListLineEntity.availability?.message ?? '',
    style: OptiTextStyles.body,
  );
}
