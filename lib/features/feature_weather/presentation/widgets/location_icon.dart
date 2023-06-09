import 'package:Hiit/core/params/forecast_params.dart';
import 'package:Hiit/core/presentation/widgets/dot_loading_widget.dart';
import 'package:Hiit/core/utils/prefs_operator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Hiit/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/lw_status.dart';
import 'package:Hiit/locator.dart';
import 'package:location/location.dart';

// ignore: must_be_immutable
class LocationIcon extends StatelessWidget {
  final String cityName;

  LocationIcon({super.key, required this.cityName});

  /// local operation
  PrefsOperator prefsOperator = locator();

  /// location operation
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  Future<void> getUserLocation(BuildContext context) async {
    Location location = Location();
    var cityNameSelected = prefsOperator.getCitySelected();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        BlocProvider.of<HomeBloc>(context).add(
          LoadCwEvent(cityNameSelected ?? cityName),
        );
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        /// call api with default
        BlocProvider.of<HomeBloc>(context).add(
          LoadCwEvent(cityNameSelected ?? cityName),
        );
        return;
      }
    }

    final _locationData = await location.getLocation();

    /// create params for api call
    final ForecastParams forecastParams = ForecastParams(
      _locationData.latitude!,
      _locationData.longitude!,
    );

    BlocProvider.of<HomeBloc>(context).add(LoadLwEvent(forecastParams));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) {
        /// if state don't change => don't listen to changes
        if (current.lwStatus == previous.lwStatus) {
          return false;
        }
        return true;
      },
      buildWhen: (previous, current) {
        if (previous.lwStatus == current.lwStatus) {
          return false;
        }
        return true;
      },
      listener: (context, locationState) {
        if (locationState.lwStatus is LwCompleted) {
          /// cast
          final LwCompleted lwCompleted = locationState.lwStatus as LwCompleted;
          final CurrentCityEntity currentCityEntity =
              lwCompleted.currentCityEntity;

          /// save city name from current location
          prefsOperator.saveCitySelected(currentCityEntity.name!);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Location completed"),
              behavior: SnackBarBehavior.floating, // Add this line
            ),
          );
        }

        /// show Error State for Lw
        if (locationState.lwStatus is LwError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Location is not received !"),
              behavior: SnackBarBehavior.floating, // Add this line
            ),
          );
        }
      },
      builder: (context, state) {
        /// show Loading State for Lw
        if (state.lwStatus is LwLoading) {
          return const DotLoadingWidget();
        }
        return IconButton(
          onPressed: () {
            getUserLocation(context);
          },
          icon: Icon(
            Icons.location_on_outlined,
            color: Colors.white,
            size: height * 0.04,
          ),
        );
      },
    );
  }
}
