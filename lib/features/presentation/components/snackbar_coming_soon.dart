import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showComingSoonSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Coming Soon"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showProductAddedToCart(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Product Added to Cart"),
        duration: Duration(seconds: 1),
      ),
    );
  }

    static void showInvalidCVV(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Invalid CVV"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showPoNumberRequired(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("PO Number Required"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

}
