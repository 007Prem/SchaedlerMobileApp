import 'package:flutter/material.dart';

import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';

class FilterValueViewModel {
  FilterValueViewModel({
    required this.id,
    required this.title,
    this.facetType,
    this.isSelected,
  });

  final String id;

  final String title;

  final FacetType? facetType;

  final bool? isSelected;

  FilterValueViewModel copyWith({
    String? id,
    String? title,
    FacetType? facetType,
    bool? isSelected,
  }) {
    return FilterValueViewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      facetType: facetType ?? this.facetType,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class FilterValueViewModelCollection {
  final int? maxItemsToShow;
  final List<FilterValueViewModel> values;
  final String title;

  FilterValueViewModelCollection({
    this.maxItemsToShow,
    required this.values,
    required this.title,
  });

  FilterValueViewModelCollection copyWith({
    int? maxItemsToShow,
    List<FilterValueViewModel>? values,
    String? title,
  }) {
    return FilterValueViewModelCollection(
      maxItemsToShow: maxItemsToShow ?? this.maxItemsToShow,
      values: values ?? this.values,
      title: title ?? this.title,
    );
  }

  bool get anyFiltersSelected {
    return values.any((element) => element.isSelected == true);
  }
}

enum FacetType {
  previouslyPurchased,
  stockedItemsFacet,
  attributeValueFacet,
  brandFacet,
  productLineFacet,
  categoryFacet
}

void showFilterModalSheet(
  BuildContext context, {
  required void Function() onApply,
  required void Function()? onReset,
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
      return SafeArea(
        child: Container(
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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Text(
                            LocalizationConstants.filter.localized(),
                            style: OptiTextStyles.titleLarge,
                          ),
                        ),
                        child,
                      ],
                    ),
                  ),
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
                    if (onReset != null)
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: SecondaryButton(
                            onPressed: onReset,
                            child: Text(LocalizationConstants.reset.localized()),
                          ),
                        ),
                      ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        width: 176,
                        height: 48,
                        child: PrimaryButton(
                          text: LocalizationConstants.apply.localized(),
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
        ),
      );
    },
  );
}

class FilterOptionsChip extends StatelessWidget {
  const FilterOptionsChip({
    super.key,
    required this.label,
    required this.values,
    required this.selectedValueIds,
    required this.onSelectionIdAdded,
    required this.onSelectionIdRemoved,
  });

  final String label;
  final List<FilterValueViewModel> values;
  final Set<String> selectedValueIds;
  final void Function(String selectionId) onSelectionIdAdded;
  final void Function(String selectionId) onSelectionIdRemoved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Text(
            label,
            style: OptiTextStyles.body.copyWith(
              color: OptiAppColors.textSecondary,
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 2,
          children: values
              .map(
                (value) => FilterChip(
                  label: Text(
                    value.title,
                    style: selectedValueIds.contains(value.id)
                        ? OptiTextStyles.bodySmallHighlight
                            .copyWith(color: OptiAppColors.backgroundWhite)
                        : OptiTextStyles.bodySmallHighlight,
                  ),
                  selectedColor: OptiAppColors.textPrimary,
                  showCheckmark: false,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  selected: selectedValueIds.contains(value.id),
                  onSelected: (bool selected) {
                    if (selected) {
                      onSelectionIdAdded(value.id);
                    } else {
                      onSelectionIdRemoved(value.id);
                    }
                  },
                  backgroundColor: OptiAppColors.backgroundWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: const BorderSide(
                      color: OptiAppColors.textPrimary,
                      width: 1,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class FilterOptionSwitch extends StatelessWidget {
  const FilterOptionSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final void Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: OptiTextStyles.body,
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
