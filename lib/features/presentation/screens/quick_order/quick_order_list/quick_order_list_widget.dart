import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/quick_order_item_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quick_order/order_list/order_list_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quick_order/quick_order_list/quick_order_item_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quick_order/quick_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuickOrderListWidget extends StatelessWidget {

  final Function(BuildContext context, QuickOrderItemEntity, OrderCallBackType orderCallBackType) callback;

  QuickOrderListWidget({required this.callback});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderListBloc, OrderListState>(
        listener: (context, state) {},
        buildWhen: (previous, current) =>
            current is OrderListInitialState ||
            current is OrderListLoadingState ||
            current is OrderListLoadedState ||
            current is OrderListFailedState,
        builder: (context, state) {
          switch (state) {
            case OrderListInitialState():
            case OrderListFailedState():
              return Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'To add an item to your quick order form, search by keyword or item # then click on the item',
                    style: OptiTextStyles.body,
                  )
                ],
              );
            case OrderListLoadingState():
              return const Center(child: CircularProgressIndicator());
            case OrderListLoadedState():
              return ListView.builder(
                itemCount: state.quickOrderItemList.length,
                itemBuilder: (context, index) {
                  var entity = state.quickOrderItemList[index];
                  return QuickOrderItemWidget(
                    callback: callback,
                    quickOrderItemEntity: entity,
                  );
                },
              );
            default:
              return Container();
          }
        });
  }
}