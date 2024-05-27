import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/map_cubit/gmap_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/vmi/vmi_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LocationSearchScreen extends StatelessWidget {
  const LocationSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LocationSearchBloc>(
          create: (context) => sl<LocationSearchBloc>()),
      BlocProvider<VMILocationBloc>(
          create: (context) =>
              sl<VMILocationBloc>()..add(LoadVMILocationsEvent())),
      BlocProvider<GMapCubit>(create: (context) => sl<GMapCubit>())
    ], child: LocationSearchPage());
  }
}

class LocationSearchPage extends StatelessWidget {
  LocationSearchPage({super.key});
  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: const Text('VMI'),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Input(
                    hintText: LocalizationConstants.search,
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(
                        AssetConstants.iconClear,
                        semanticsLabel: 'search query clear icon',
                        fit: BoxFit.fitWidth,
                      ),
                      onPressed: () {
                        textEditingController.clear();
                        context.closeKeyboard();
                      },
                    ),
                    onTapOutside: (p0) => context.closeKeyboard(),
                    textInputAction: TextInputAction.search,
                    focusListener: (bool hasFocus) {
                      if (hasFocus) {
                        context
                            .read<LocationSearchBloc>()
                            .add(LocationSearchFocusEvent());
                      } else {}
                    },
                    onChanged: (String searchQuery) {},
                    onSubmitted: (String query) {},
                    controller: textEditingController,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: MultiBlocListener(
            listeners: [
              BlocListener<LocationSearchBloc, LoactionSearchState>(
                listener: (context, state) {
                  if (state is LocationSearchFocusState) {
                    // _showSearchResults = true;
                  }
                },
              ),
            ],
            child: BlocBuilder<LocationSearchBloc, LoactionSearchState>(
              builder: (_, state) {
                if (state is LocationSearchLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LocationSearchInitialState) {
                  return Container(child: VMILocationScreen());
                } else if (state is LocationSearchLoadedState) {
                  return Container(child: Text('LocationSearchLoadedState'));
                } else if (state is LocationSearchFocusState) {
                  return Container(child: Text('LocationSearchFocusState'));
                } else {
                  return Container();
                }
              },
            ),
          ))
        ],
      ),
    );
  }
}
