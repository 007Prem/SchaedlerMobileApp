import 'dart:math';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';

class DiscountValueConverter {
  String? convert(dynamic value) {
    String? unitListPriceDisplay;
    double? unitListPrice = 0;
    double? unitNetPrice = 0;

    if (value is ProductPriceEntity) {
      unitListPriceDisplay = value.unitListPriceDisplay;
      unitListPrice = value.unitListPrice as double?;
      unitNetPrice = value.unitNetPrice as double?;
    }
    // else if (value is OrderLine) {
    //   unitListPriceDisplay = value.unitListPriceDisplay;
    //   unitListPrice = value.unitListPrice;
    //   unitNetPrice = value.unitNetPrice;
    // } else if (value is InvoiceLine) {
    //   var savingsAmount = value.discountAmount;
    //   var discountMessage =
    //       "${LocalizationConstants.keyword.regularPrice.localized()}: ${value.unitPriceDisplay}";
    //   if (value.discountPercent > 0) {
    //     var savingPercent = (value.discountPercent).round();
    //     discountMessage +=
    //         ", ${LocalizationConstants.keyword.youSave.localized()} ${CoreConstants.currencySymbol}${savingsAmount.toStringAsFixed(2)} ($savingPercent%)";
    //   }

    //   return discountMessage;
    // }

    if (unitListPriceDisplay != null &&
        unitListPrice != 0 &&
        unitListPrice! > unitNetPrice!) {
      var savingsAmount = unitListPrice - unitNetPrice;
      var savingPercent =
          ((unitListPrice - unitNetPrice) / unitListPrice * 100).round();
      var discountMessage =
          "${LocalizationConstants.regularPrice}: $unitListPriceDisplay, ${LocalizationConstants.youSave} ${CoreConstants.currencySymbol}${savingsAmount.toStringAsFixed(2)} ($savingPercent%)";
      return discountMessage;
    }

    return null;
  }
}
