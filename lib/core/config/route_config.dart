import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/features/domain/entity/biometric_info_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/presentation/helper/routing/navigation_node.dart';
import 'package:commerce_flutter_app/features/presentation/helper/routing/route_generator.dart';
import 'package:commerce_flutter_app/features/presentation/screens/account/account_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/biometric/biometric_login_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/checkout_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/checkout_success_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/payment_details/checkout_payment_details.dart';
import 'package:commerce_flutter_app/features/presentation/screens/lists/lists_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/login/login_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/nav_bar/nav_bar_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/order_history/order_history_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details.dart';
import 'package:commerce_flutter_app/features/presentation/screens/root/root_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/search/search_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/settings/settings_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/shop/shop_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/domain_selection_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

GoRouter getRouter() {
  return GoRouter(
    navigatorKey: _rootNavigator,
    initialLocation: AppRoute.root.fullPath,
    debugLogDiagnostics: true,
    routes: _getNavigationRoot().map((e) => generateRoutes(e)).toList(),
  );
}

List<NavigationNode> _getNavigationRoot() {
  // path: /
  final root = createNode(
    path: AppRoute.root.fullPath,
    name: AppRoute.root.name,
    builder: (context, state) => const RootScreen(),
  );

  // path: /welcome
  final welcome = createNode(
    name: AppRoute.welcome.name,
    path: AppRoute.welcome.suffix,
    builder: (context, state) => const WelcomeScreen(),
  );

  // path: /domainSelection
  final domainSelection = createNode(
    name: AppRoute.domainSelection.name,
    path: AppRoute.domainSelection.suffix,
    builder: (context, state) => const DomainScreen(),
  );

  // path: /login
  final login = createSeparateRoute(
    name: AppRoute.login.name,
    path: AppRoute.login.suffix,
    builder: (context, state) => const LoginScreen(),
    navigatorKey: _rootNavigator,
    parent: null,
  );

  final navbarRoot = createNavbarRoot(
    statefulShellBuilder: (context, state, navigationShell) => NavBarScreen(
      navigationShell: navigationShell,
    ),
    parent: null,
  );

  // path: /shop
  final shop = createNode(
    name: AppRoute.shop.name,
    path: AppRoute.shop.suffix,
    builder: (context, state) => const ShopScreen(),
    parent: navbarRoot,
  );

  // path: /search
  final search = createNode(
    name: AppRoute.search.name,
    path: AppRoute.search.suffix,
    builder: (context, state) => const SearchScreen(),
    parent: navbarRoot,
  );

  // path: /account
  final account = createNode(
    name: AppRoute.account.name,
    path: AppRoute.account.suffix,
    builder: (context, state) => const AccountScreen(),
    parent: navbarRoot,
  );

  // path: /cart
  final cart = createNode(
    name: AppRoute.cart.name,
    path: AppRoute.cart.suffix,
    builder: (context, state) => const CartScreen(),
    parent: navbarRoot,
  );

  // path: /checkout
  final checkout = createNode(
    name: AppRoute.checkout.name,
    path: AppRoute.checkout.suffix,
    builder: (context, state) {
      final cart = state.extra as Cart;
      return CheckoutScreen(cart: cart);
    },
    parent: null,
  );

  // path: /checkoutSuccess
  final checkoutSuccess = createNode(
    name: AppRoute.checkoutSuccess.name,
    path: AppRoute.checkoutSuccess.suffix,
    builder: (context, state) {
      final orderNumber = state.extra as String;
      return CheckoutSuccessScreen(orderNumber: orderNumber);
    },
    parent: null,
  );

  // path: /product details
  final productDetails = createNode(
    name: AppRoute.productDetails.name,
    path: AppRoute.productDetails.suffix,
    builder: (context, state) => ProductDetailsScreen(
        productId: state.pathParameters['productId'] ?? '',
        product: state.extra as ProductEntity),
    parent: shop,
  );

  // path: /account/settings
  final settings = createNode(
    name: AppRoute.settings.name,
    path: AppRoute.settings.suffix,
    builder: (context, state) => const SettingsScreen(),
    parent: account,
  );

  // path: /biometric
  final biometricLogin = createNode(
    name: AppRoute.biometricLogin.name,
    path: AppRoute.biometricLogin.suffix,
    builder: (context, state) {
      final biometricInfo = state.extra as BiometricInfoEntity;
      return BiometricLoginScreen(
        biometricOption: biometricInfo.biometricOption,
        password: biometricInfo.password,
      );
    },
    parent: null,
  );

  // path: /account/orderHistory
  final orderHistory = createNode(
    name: AppRoute.orderHistory.name,
    path: AppRoute.orderHistory.suffix,
    builder: (context, state) => const OrderHistoryScreen(),
    parent: account,
  );

  // path: /account/list
  final lists = createNode(
    name: AppRoute.lists.name,
    path: AppRoute.lists.suffix,
    builder: (context, state) => const ListsScreen(),
    parent: account,
  );

  return [
    root,
    navbarRoot,
    welcome,
    domainSelection,
    login,
    biometricLogin,
    checkout,
    checkoutSuccess,
  ];
}
