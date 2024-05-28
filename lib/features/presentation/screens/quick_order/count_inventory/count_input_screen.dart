import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/date_time_extension.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/vmi_bin_model_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/number_text_field.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/count_inventory/count_inventory_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CountInventoryEntity {
  final VmiBinModelEntity vmiBinEntity;
  final OrderEntity? previousOrder;
  int? qty;

  CountInventoryEntity(
      {required this.vmiBinEntity, this.previousOrder, this.qty});
}

class CountInventoryScreen extends StatelessWidget {
  final CountInventoryEntity countInventoryEntity;

  const CountInventoryScreen({super.key, required this.countInventoryEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CountInventoryCubit>(),
      child: CountInputPage(countInventoryEntity: countInventoryEntity),
    );
  }
}

class CountInputPage extends StatefulWidget {
  final CountInventoryEntity countInventoryEntity;

  const CountInputPage({super.key, required this.countInventoryEntity});

  @override
  State<CountInputPage> createState() => _CountInputPageState();
}

class _CountInputPageState extends State<CountInputPage> {
  final _qtyController = TextEditingController();
  bool isUpdateEnable = true;

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CountInventoryCubit, CountInventoryState>(
      listener: (context, state) {
        if (state is CountInventoryAlert) {
          _showAlertDialog(state.message);
          setState(() {
            isUpdateEnable = !isUpdateEnable;
          });
        } else if (state is CountInventorySuccess) {
          widget.countInventoryEntity.qty = state.qty;
          context.pop(widget.countInventoryEntity);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: OptiAppColors.backgroundWhite,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Container(
          color: OptiAppColors.backgroundWhite,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductListItemWithTitleAndNumber(
                        imageUrl: widget.countInventoryEntity.vmiBinEntity
                            .productEntity?.smallImagePath,
                        title: widget.countInventoryEntity.vmiBinEntity
                            .productEntity?.shortDescription,
                        productNumber: widget.countInventoryEntity.vmiBinEntity
                            .productEntity?.erpNumber,
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: OptiAppColors.backgroundGray,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildSelectableContainer(
                                  text: LocalizationConstants.history,
                                  isSelected: selectedIndex == 0,
                                  onTap: () {
                                    if (selectedIndex != 0) {
                                      setState(() {
                                        selectedIndex = 0;
                                      });
                                    }
                                  },
                                ),
                                _buildSelectableContainer(
                                  text: LocalizationConstants.productInfo,
                                  isSelected: selectedIndex == 1,
                                  onTap: () {
                                    if (selectedIndex != 1) {
                                      setState(() {
                                        selectedIndex = 1;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: selectedIndex == 0 ? _getHistoryWidget() : _getProductInfoWidget(),
                      ),
                      _getQtyInputWidget()
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(color: Colors.white),
                child: PrimaryButton(
                  onPressed: () {
                    setState(() {
                      isUpdateEnable = !isUpdateEnable;
                    });
                    context.read<CountInventoryCubit>().updateInventoryQuantity(
                        widget.countInventoryEntity.vmiBinEntity,
                        _qtyController.text);
                  },
                  isEnabled: isUpdateEnable,
                  text: LocalizationConstants.update,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectableContainer({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? OptiAppColors.backgroundWhite : OptiAppColors.backgroundGray,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                text,
                style: OptiTextStyles.subtitle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(String message) {
    displayDialogWidget(context: context, message: message, actions: [
      DialogPlainButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(LocalizationConstants.oK),
      ),
    ]);
  }

  Widget _getQtyInputWidget() {
    int? qty =
        widget.countInventoryEntity.vmiBinEntity.lastCountQty?.toInt() ?? 0;
    int previousQty = qty;
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocalizationConstants.qTY, style: OptiTextStyles.body),
          NumberTextField(
            initialtText: qty.toString(),
            shouldShowIncrementDecermentIcon: false,
            controller: _qtyController,
            onChanged: (value) {
              qty = value;
            },
            focusListener: (hasFocus) {
              if (!hasFocus) {
                if (qty != null) {
                  previousQty = qty!;
                } else {
                  qty ??= previousQty;
                  _qtyController.text = (qty ?? 0).toString();
                }
              }
            },
          )
        ],
      ),
    );
  }

  Widget _getHistoryWidget() {
    return Column(
      children: [
        _getPreviousCountWidget(),
        _getPreviousOrderWidget(),
      ],
    );
  }

  Widget _getPreviousCountWidget() {
    List<Widget> list = [];

    final date = _buildRow(
        LocalizationConstants.dateSign,
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.vmiBinEntity.previousCountDate
            .formatDate(format: 'dd/MM/yyyy'),
        OptiTextStyles.body);
    final countQty = _buildRow(
        LocalizationConstants.countQTYSign,
        OptiTextStyles.subtitle,
        (widget.countInventoryEntity.vmiBinEntity.previousCountQty?.toInt() ??
                0)
            .toString(),
        OptiTextStyles.body);

    if (date != null) {
      list.add(date);
    }
    if (countQty != null) {
      list.add(countQty);
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocalizationConstants.previousCount,
              style: OptiTextStyles.titleLarge),
          ...list
        ],
      ),
    );
  }

  Widget _getPreviousOrderWidget() {
    List<Widget> list = [];

    final date = _buildRow(
        LocalizationConstants.dateSign,
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.previousOrder?.orderDate
                .formatDate(format: 'dd/MM/yyyy') ??
            '',
        OptiTextStyles.body);
    final countQty = _buildRow(
        LocalizationConstants.orderQTYSign,
        OptiTextStyles.subtitle,
        _getPreviousOrderQty(widget.countInventoryEntity.previousOrder,
            widget.countInventoryEntity.vmiBinEntity),
        OptiTextStyles.body);
    final order = _buildRow(
        LocalizationConstants.orderSign,
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.previousOrder?.orderNumber ?? '',
        OptiTextStyles.body);

    if (date != null) {
      list.add(date);
    }
    if (countQty != null) {
      list.add(countQty);
    }
    if (order != null) {
      list.add(order);
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocalizationConstants.previouseOrder,
              style: OptiTextStyles.titleLarge),
          ...list
        ],
      ),
    );
  }

  Widget _getProductInfoWidget() {
    List<Widget> list = [];

    final part = _buildRow(
        LocalizationConstants.partNumberSign,
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.vmiBinEntity.productEntity?.productNumber ??
            '',
        OptiTextStyles.body);
    final myPart = _buildRow(
        LocalizationConstants.myPartNumberSign,
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.vmiBinEntity.productEntity?.customerName ??
            '',
        OptiTextStyles.body);
    final mfg = _buildRow(
        LocalizationConstants.mFGNumberSign,
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.vmiBinEntity.productEntity
                ?.manufacturerItem ??
            '',
        OptiTextStyles.body);
    final bin = _buildRow(
        LocalizationConstants.binSign,
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.vmiBinEntity.binNumber ?? '',
        OptiTextStyles.body);
    final maxCount = _buildRow(
        LocalizationConstants.maxSign,
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.vmiBinEntity.maximumQty?.toInt().toString() ?? '',
        OptiTextStyles.body);
    final minCount = _buildRow(
        LocalizationConstants.minSign,
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.vmiBinEntity.minimumQty?.toInt().toString() ?? '',
        OptiTextStyles.body);

    if (part != null) {
      list.add(part);
    }
    if (myPart != null) {
      list.add(myPart);
    }
    if (mfg != null) {
      list.add(mfg);
    }
    if (bin != null) {
      list.add(bin);
    }
    if (maxCount != null) {
      list.add(maxCount);
    }
    if (minCount != null) {
      list.add(minCount);
    }

    return Expanded(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: list,
            ),
          )
        ],
      ),
    );
  }

  Widget? _buildRow(String title, TextStyle titleTextStyle, String body,
      TextStyle bodyTextStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: titleTextStyle,
              ),
            ),
          ),
          Text(
            body,
            textAlign: TextAlign.start,
            style: bodyTextStyle,
          )
        ],
      ),
    );
  }

  String _getPreviousOrderQty(
      OrderEntity? previousOrder, VmiBinModelEntity vmiBinEntity) {
    if (previousOrder?.orderLines?.isNotEmpty ?? false) {
      for (var orderLine in previousOrder?.orderLines ?? []) {
        if (orderLine.productId == (vmiBinEntity.productEntity?.id ?? '')) {
          return orderLine.qtyOrdered.toInt().toString();
        }
      }
    }
    return '';
  }
}

class ProductListItemWithTitleAndNumber extends StatelessWidget {
  final String? imageUrl, title, productNumber;

  const ProductListItemWithTitleAndNumber(
      {this.imageUrl, this.title, this.productNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: const Color(0xFFD6D6D6)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl.makeImageUrl(),
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    // This function is called when the image fails to load
                    return Container(
                      color: OptiAppColors.backgroundGray, // Placeholder color
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image, // Icon to display
                        color: Colors.grey, // Icon color
                        size: 30, // Icon size
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: OptiTextStyles.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  LocalizationConstants.itemNumber
                      .format([productNumber ?? '']),
                  style: OptiTextStyles.bodySmall.copyWith(
                    color: OptiAppColors.textDisabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
