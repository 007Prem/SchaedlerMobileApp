import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_state.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/number_text_field.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsAddToCartWidget extends StatelessWidget {
  const ProductDetailsAddToCartWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        color: AppStyle.neutral00,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              return state.status == AuthStatus.authenticated
                  ? AddToCartSignInWidget()
                  : AddToCartNotSignedInWidget();
            },
          ),
        ),
      ),
    );
  }
}

class AddToCartSignInWidget extends StatelessWidget {
  final textEditingController = TextEditingController();

  AddToCartSignInWidget();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsAddToCartBloc,
        ProductDetailsAddtoCartState>(builder: (context, state) {
      switch (state) {
        case ProductDetailsAddtoCartInitial():
        case ProductDetailsAddtoCartLoading():
          return const Center(child: CircularProgressIndicator());
        case ProductDetailsAddtoCartSuccess():
          var detailsAddToCartEntity = state.productDetailsAddToCartEntity;
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: NumberTextField(
                            initialtText: detailsAddToCartEntity.quantityText,
                            onChanged: (int? quantity) {
                              var pricingState = context
                                  .read<ProductDetailsPricingBloc>()
                                  .state;
                              if (pricingState is ProductDetailsPricingLoaded) {
                                var productDetailsPricingEntity =
                                    pricingState.productDetailsPriceEntity;
                                productDetailsPricingEntity =
                                    productDetailsPricingEntity.copyWith(
                                        quantity: quantity);
                                context.read<ProductDetailsPricingBloc>().add(
                                    LoadProductDetailsPricing(
                                        productDetailsPriceEntity:
                                            productDetailsPricingEntity));
                              }
                            }),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text('U/M'),
                            Text('E/A',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0))
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text('Subtotal'),
                            Text(
                              detailsAddToCartEntity?.subtotalValueText ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18.0),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                PrimaryButton(
                  child: const Text(LocalizationConstants.addToCart),
                  onPressed: () {},
                )
              ],
            ),
          );
        case ProductDetailsAddtoCartError():
          return Center(child: Text(state.errorMessage));
        default:
          return const Center(child: Text("failure"));
      }
    });
  }
}

class QuantityTextChangeEvent {}

class AddToCartNotSignedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      child: const Text(LocalizationConstants.signInForAddToCart),
      onPressed: () {
        // context.push(AppRoute.login.path);
        AppRoute.login.navigate(context);
      },
    );
  }
}
