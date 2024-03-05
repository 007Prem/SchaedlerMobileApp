import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductDetailsPricingWidget extends StatelessWidget {
  final ProductDetailsPriceEntity productDetailsPricingEntity;

  const ProductDetailsPricingWidget(
      {required this.productDetailsPricingEntity});

  @override
  Widget build(BuildContext context) {
    var event = context.read<ProductDetailsPricingBloc>();

    event.add(LoadProductDetailsPricing(
        productDetailsPriceEntity: productDetailsPricingEntity));

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDiscountMessageSection(context),
              _buildPricingSection(context),
              GestureDetector(
                onTap: () {
                  // TODO: Implement the logic for "View Quantity Pricing"
                },
                child: const Text("View Quantity Pricing",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12)),
              ),
              _buildInventorySection(context),
              // For "View Availability by Warehouse"
              GestureDetector(
                onTap: () {
                  // TODO: Implement the logic for "View Quantity Pricing"
                },
                child: const Text("View Availability by Warehouse",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountMessageSection(BuildContext context) {
    return BlocBuilder<ProductDetailsPricingBloc, ProductDetailsPricingState>(
      buildWhen: (previous, current) {
        if (previous is ProductDetailsPricingLoaded &&
            current is ProductDetailsPricingLoaded) {
          return previous.productDetailsPriceEntity.discountMessage !=
              current.productDetailsPriceEntity.discountMessage;
        } else if (previous is ProductDetailsPricingLoading &&
            current is ProductDetailsPricingLoaded) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is ProductDetailsPricingLoaded) {
          var discountMessage = state.productDetailsPriceEntity.discountMessage;
          if (discountMessage != null &&
              discountMessage.isNotEmpty &&
              discountMessage != "null") {
            return Text(
              discountMessage,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  color: AppColors.lightGrayTextColor),
            );
          }
        }
        return Container();
      },
    );
  }

  Widget _buildPricingSection(BuildContext context) {
    return BlocBuilder<ProductDetailsPricingBloc, ProductDetailsPricingState>(
      builder: (context, state) {
        if (state is ProductDetailsPricingLoaded) {
          var productDetailsPriceEntity = state.productDetailsPriceEntity;
          return Container(
            child: Row(
              children: [
                Text(productDetailsPriceEntity.priceValueText ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                    '/${productDetailsPriceEntity.selectedUnitOfMeasureValueText ?? ''}'),
              ],
            ),
          );
        }
        return Container(
          alignment: Alignment.bottomLeft,
          child: LoadingAnimationWidget.prograssiveDots(
            color: Colors.black87,
            size: 30,
          ),
        );
      },
    );
  }

  Widget _buildInventorySection(BuildContext context) {
    return BlocBuilder<ProductDetailsPricingBloc, ProductDetailsPricingState>(
      builder: (context, state) {
        if (state is ProductDetailsPricingLoaded) {
          var productDetailsPriceEntity = state.productDetailsPriceEntity;
          return Container(
            child: Text(productDetailsPriceEntity.availability?.message ?? ''),
          );
        }
        return Container(
          alignment: Alignment.bottomLeft,
          child: LoadingAnimationWidget.prograssiveDots(
            color: Colors.black87,
            size: 30,
          ),
        );
      },
    );
  }
}
