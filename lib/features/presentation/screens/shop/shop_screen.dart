import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cms/cms_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void _reloadShopPage(BuildContext context) {
  context.read<ShopPageBloc>().add(const ShopPageLoadEvent());
}

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CmsCubit>(create: (context) => sl<CmsCubit>()),
      BlocProvider<ShopPageBloc>(
        create: (context) => sl<ShopPageBloc>()..add(const ShopPageLoadEvent()),
      ),
    ], child: const ShopPage());
  }
}

class ShopPage extends BaseDynamicContentScreen {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        BottomMenuWidget(),
      ]),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              _reloadShopPage(context);
            },
          ),
          BlocListener<DomainCubit, DomainState>(
            listener: (context, state) {
              if (state is DomainLoaded) {
                _reloadShopPage(context);
              }
            },
          ),
          BlocListener<ShopPageBloc, ShopPageState>(
            listener: (context, state) {
              switch(state) {
                case ShopPageLoadingState():
                  context.read<CmsCubit>().loading();
                case ShopPageLoadedState():
                  context.read<CmsCubit>().buildCMSWidgets(state.pageWidgets);
                case ShopPageFailureState():
                  context.read<CmsCubit>().failedLoading();
              }
            },
          ),
        ],
        child: BlocBuilder<CmsCubit, CmsState>(
          builder: (context, state) {
            switch(state) {
              case CmsInitialState():
              case CmsLoadingState():
                return const Center(child: CircularProgressIndicator());
              case CmsLoadedState():
                return Scaffold(
                    body: ListView(
                      children: buildContentWidgets(state.widgetEntities),
                    ));
              default:
                return const Center(child: Text('Failed Loading Shop'));
            }
          },
        ),
      ),
    );
  }

// List<ToolMenu> _getToolMenu(BuildContext context) {
//   List<ToolMenu> list = [];
//   list.add(ToolMenu(
//     title: "Setting",
//     action: () {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("Sending Message"),
//       ));
//     }
//   ));
//   return list;
// }
}
