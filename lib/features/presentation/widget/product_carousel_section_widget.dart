import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/widget/product_carousel_item_widget.dart';
import 'package:flutter/material.dart';

class ProductCarouselSectionWidget extends StatelessWidget {
  final ProductCarouselWidgetEntity productCarouselWidgetEntity;

  const ProductCarouselSectionWidget({super.key, required this.productCarouselWidgetEntity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              productCarouselWidgetEntity.title,
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 168,
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 8,
              ),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (context, index) {
                return ProductCarouselItemWidget();
              },
            ),
          )
        ],
      ),
    );
  }
}
