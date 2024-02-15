import 'package:commerce_flutter_app/core/extensions/html_string_extension.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_detail_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ProductDetailsExpansionItemWidget extends StatelessWidget {
  final ProductDetailItemEntity specification;

  const ProductDetailsExpansionItemWidget(
      {Key? key, required this.specification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(dividerColor: Colors.white),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        title: Text(specification.title),
        collapsedBackgroundColor: Colors.white,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: HtmlWidget(
              specification.htmlContent.styleHtmlContent() ?? '',
            ),
          ),
        ],
      ),
    );
  }
}
