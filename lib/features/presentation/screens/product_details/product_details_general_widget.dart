import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_general_info_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/carousel_indicator/carousel_indicator_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsGeneralWidget extends StatelessWidget {
  final ProductDetailsGeneralInfoEntity generalInfoEntity;

  const ProductDetailsGeneralWidget({Key? key, required this.generalInfoEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocProvider(
            create: (context) => CarouselIndicatorCubit(),
            child: ProductDetailsCarouselWidget(
              generalInfoEntity: generalInfoEntity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  generalInfoEntity.productName ?? '',
                  style: context.textTheme.headlineMedium,
                  textAlign: TextAlign.left,
                ),
                if (generalInfoEntity.originalPartNumberValue != null)
                  Text(
                    generalInfoEntity.originalPartNumberValue ?? '',
                    style: context.textTheme.bodySmall,
                    textAlign: TextAlign.left,
                  ),
                if (generalInfoEntity.myPartNumberValue != null &&
                    generalInfoEntity.myPartNumberValue!.isNotEmpty)
                  Row(children: [
                    Text(
                      generalInfoEntity.myPartNumberTitle ?? '',
                      style: context.textTheme.bodySmall,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      generalInfoEntity.myPartNumberValue ?? '',
                      style: context.textTheme.bodySmall,
                      textAlign: TextAlign.left,
                    ),
                  ]),
                if (generalInfoEntity.mFGNumberValue != null &&
                    generalInfoEntity.mFGNumberValue!.isNotEmpty)
                  Row(children: [
                    Text(
                      generalInfoEntity.mFGNumberTitle ?? '',
                      style: context.textTheme.bodySmall,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      generalInfoEntity.mFGNumberValue ?? '',
                      style:
                          const TextStyle(color: AppColors.lightGrayTextColor),
                      textAlign: TextAlign.left,
                    ),
                  ]),
                if (generalInfoEntity.packDescriptionValue != null &&
                    generalInfoEntity.packDescriptionValue!.isNotEmpty)
                  Row(children: [
                    Text(
                      generalInfoEntity.packDescriptionTitle ?? '',
                      style: context.textTheme.bodySmall,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      generalInfoEntity.packDescriptionValue ?? '',
                      style: context.textTheme.bodySmall,
                      textAlign: TextAlign.left,
                    ),
                  ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
