import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:flutter/material.dart';

void showFilterModalSheet(
  BuildContext context, {
  required void Function() onApply,
  required void Function() onReset,
  required Widget child,
}) {
  showModalBottomSheet(
    useRootNavigator: true,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (innerContext) {
      return Container(
        decoration: const BoxDecoration(
          color: OptiAppColors.backgroundWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Text(
                      LocalizationConstants.filter,
                      style: OptiTextStyles.titleLarge,
                    ),
                  ),
                  child,
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: OptiAppColors.backgroundWhite,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 5,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 13.5,
                horizontal: 31.5,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: SecondaryButton(
                        onPressed: onReset,
                        child: const Text(LocalizationConstants.reset),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      width: 176,
                      height: 48,
                      child: PrimaryButton(
                        text: LocalizationConstants.apply,
                        onPressed: () {
                          onApply();
                          Navigator.pop(innerContext);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showOrderHistoryFilter(
  BuildContext context, {
  required void Function() onApply,
}) {
  showFilterModalSheet(
    context,
    onApply: onApply,
    onReset: () {},
    child: Text(
      'Somevalue',
      style: OptiTextStyles.titleSmall,
    ),
  );
}
