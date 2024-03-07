import 'package:commerce_flutter_app/core/config/prod_config_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initialHiveDatabase();
  initCommerceSDK();
  initInjectionContainer();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthCubit>()),
        BlocProvider(create: (context) => sl<LogoutCubit>()),
        BlocProvider(create: (context) => sl<DomainCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

void initialHiveDatabase() async {
  await Hive.initFlutter();
}

void initCommerceSDK() {
  ClientConfig.hostUrl = null;
  ClientConfig.clientId = ProdConfigConstants.clientId;
  ClientConfig.clientSecret = ProdConfigConstants.clientSecret;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My App',
      routerConfig: sl<GoRouter>(),
      theme: lightTheme,
    );
  }
}

class NavBarScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavBarScreen({
    super.key,
    required this.navigationShell,
  });

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        items: _buildBottomNavigationBarItems(),
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
      body: navigationShell,
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    return [
      _buildBottomNavigationBarItem(
        0,
        "assets/images/bar_icons/shop.svg",
        "assets/images/bar_icons/shop_selected.svg",
        LocalizationConstants.shopTitle,
      ),
      _buildBottomNavigationBarItem(
        1,
        "assets/images/bar_icons/search.svg",
        "assets/images/bar_icons/search_selected.svg",
        LocalizationConstants.searchLandingTitle,
      ),
      _buildBottomNavigationBarItem(
        2,
        "assets/images/bar_icons/account.svg",
        "assets/images/bar_icons/account_selected.svg",
        LocalizationConstants.account,
      ),
      _buildBottomNavigationBarItem(
        3,
        "assets/images/bar_icons/cart.svg",
        "assets/images/bar_icons/cart_selected.svg",
        LocalizationConstants.cart,
      ),
    ];
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    int index,
    String unselectedIconPath,
    String selectedIconPath,
    String label,
  ) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(bottom: 5.0),
        child: _getIcon(index, unselectedIconPath, selectedIconPath),
      ),
      label: label,
    );
  }

  Widget _getIcon(
      int index, String unselectedIconPath, String selectedIconPath) {
    return navigationShell.currentIndex == index
        ? SvgPicture.asset(
            selectedIconPath,
            fit: BoxFit.fitWidth,
          )
        : SvgPicture.asset(
            unselectedIconPath,
            fit: BoxFit.fitWidth,
          );
  }
}
