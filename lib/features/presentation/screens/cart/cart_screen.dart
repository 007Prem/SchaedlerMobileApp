import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [BottomMenuWidget()],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item $index'),
              onTap: () => AppRoute.productDetails.navigate(
                context,
                pathParameters: {'id': index.toString()},
              ),
            );
          },
        ),
      ),
    );
  }
}

class DummyProductDetails extends StatelessWidget {
  const DummyProductDetails({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Product id: $id'),
          onPressed: () => AppRoute.checkout.navigateBackStack(
            context,
            pathParameters: {'id': id},
          ),
        ),
      ),
    );
  }
}

class DummyCheckout extends StatelessWidget {
  const DummyCheckout({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Checkout product $id'),
      ),
    );
  }
}
