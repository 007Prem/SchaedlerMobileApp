import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/mixins/map_mixin.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';
import 'package:flutter/material.dart';

class CurrentLocationWidgetItem extends StatelessWidget with MapDirection {
  final CurrentLocationDataEntity locationData;

  CurrentLocationWidgetItem({required this.locationData});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(locationData.locationName ?? "",
                style: OptiTextStyles.subtitle),
            Text(locationData.firestLineValue ?? "",
                style: OptiTextStyles.body),
            Text(locationData.secondLineValue ?? "",
                style: OptiTextStyles.body),
            Text(locationData.thridLineValue ?? "", style: OptiTextStyles.body),
            const SizedBox(height: 16),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Text(
                      LocalizationConstants.call,
                      textAlign: TextAlign.center,
                      style: OptiTextStyles.link,
                    ),
                    onTap: () {
                      // _onHoursClick(context);
                    },
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    child: Text(
                      LocalizationConstants.directions,
                      textAlign: TextAlign.center,
                      style: OptiTextStyles.link,
                    ),
                    onTap: () {
                      _onDirectionsClick(locationData.latLong?.latitude ?? 0.0,
                          locationData.latLong?.longitude ?? 0.0);
                    },
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    child: Text(
                      LocalizationConstants.changeLocation,
                      textAlign: TextAlign.center,
                      style: OptiTextStyles.link,
                    ),
                    onTap: () {
                      // _onDirectionsClick();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onDirectionsClick(double longitude, double latitude) async {
    await launchMap(latitude, longitude);
  }
}
