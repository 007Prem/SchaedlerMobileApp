import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list_details/wish_list_details_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list_details/wish_list_line/wish_list_line_image_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list_details/wish_list_line/wish_list_line_pricing_widgert.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list_details/wish_list_line/wish_list_line_quantity_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list_details/wish_list_line/wish_list_line_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class WishListLineWidget extends StatelessWidget {
  final WishListLineEntity wishListLineEntity;
  final bool realTimeLoading;

  const WishListLineWidget({
    super.key,
    required this.wishListLineEntity,
    this.realTimeLoading = false,
  });

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
            _buildProductDetails(realTimeLoading),
            _buildRemoveAndAddToCartButton(
              context,
              canAddToCart: wishListLineEntity.canAddToCart == true,
              wishListLineEntity: wishListLineEntity,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToProductDetails(BuildContext context) {
    var productId = wishListLineEntity.productId;
    AppRoute.productDetails.navigateBackStack(context,
        pathParameters: {"productId": productId.toString()},
        extra: ProductEntity());
  }

  Widget _buildProductImage() {
    return WishListContentProductImageWidget(
        imagePath: wishListLineEntity.smallImagePath ?? "");
  }

  Widget _buildProductDetails(bool realTimeLoading) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WishListContentProductTitleWidget(
              wishListLineEntity: wishListLineEntity),
          WishListContentPricingWidget(
            wishListLineEntity: wishListLineEntity,
            realTimeLoading: realTimeLoading,
          ),
          WishListContentQuantityGroupWidget(
            wishListLineEntity: wishListLineEntity,
            realTimeLoading: realTimeLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildRemoveAndAddToCartButton(
    BuildContext context, {
    bool canAddToCart = false,
    required WishListLineEntity wishListLineEntity,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (canAddToCart)
          InkWell(
            onTap: () {
              context.read<WishListDetailsCubit>().addWishListLineToCart(
                    wishListLineEntity,
                  );
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0).copyWith(right: 8),
              child: SizedBox(
                width: 30,
                height: 30,
                child: SvgPicture.asset(
                  AssetConstants.wishListLineAddToCartIcon,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        InkWell(
          onTap: () {
            /// TODO : Remove from wish list
            CustomSnackBar.showComingSoonSnackBar(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0).copyWith(left: 8),
            child: SizedBox(
              width: 30,
              height: 30,
              child: SvgPicture.asset(
                AssetConstants.cartItemRemoveIcon,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        )
      ],
    );
  }
}
