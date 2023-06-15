import 'dart:ui';
import 'package:Hiit/core/utils/prefs_operator.dart';
import 'package:Hiit/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:Hiit/features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:Hiit/features/feature_weather/presentation/screens/home_screen.dart';
import 'package:Hiit/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class BookmarkGestureDetectorMobile extends StatelessWidget {
  BookmarkGestureDetectorMobile({
    super.key,
    required this.pageController,
    required this.city,
  });
  final PageController pageController;
  City city;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        /// save city name selected
        PrefsOperator prefsOperator = locator();
        prefsOperator.saveCitySelected(city.name);

        /// call for getting bookmarked city Data
        BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(city.name));

        /// animate to HomeScreen for showing Data
        pageController.animateToPage(
          HomeScreen.page,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: Container(
              width: width,
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      city.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<BookmarkBloc>(
                          context,
                        ).add(
                          DeleteCityEvent(
                            city.name,
                          ),
                        );
                        BlocProvider.of<BookmarkBloc>(
                          context,
                        ).add(GetAllCityEvent());
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
