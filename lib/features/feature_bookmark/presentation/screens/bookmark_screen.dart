import 'package:Hiit/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:Hiit/features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:Hiit/features/feature_bookmark/presentation/bloc/get_all_city_status.dart';
import 'package:Hiit/features/feature_bookmark/presentation/widgets/bookmark_view/bookmark_gesture_detector_desktop.dart';
import 'package:Hiit/features/feature_bookmark/presentation/widgets/bookmark_view/bookmark_gesture_detector_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkScreen extends StatelessWidget {
  final PageController pageController;
  const BookmarkScreen({super.key, required this.pageController});
  static int page = 1;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    BlocProvider.of<BookmarkBloc>(context).add(GetAllCityEvent());

    return BlocBuilder<BookmarkBloc, BookmarkState>(
      buildWhen: (previous, current) {
        /// rebuild UI just when allCituStatus changed
        if (current.getAllCityStatus == previous.getAllCityStatus) {
          return false;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        /// show Loading for AllCityStatus
        if (state.getAllCityStatus is GetAllCityLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        /// show Completed for AllCityStatus
        if (state.getAllCityStatus is GetAllCityCompleted) {
          /// casting for getting cities
          GetAllCityCompleted getAllCityCompleted =
              state.getAllCityStatus as GetAllCityCompleted;
          List<City> cities = getAllCityCompleted.cities;

          return SafeArea(
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                const Text(
                  'WatchList',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  /// show text in center if there is no city bookmarked
                  child: (cities.isEmpty)
                      ? const Center(
                          child: Text(
                            'there is no bookmark city',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : ListView.builder(
                          itemCount: cities.length,
                          itemBuilder: (context, index) {
                            City city = cities[index];
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.minWidth > 360) {
                                  return BookmarkGestureDetectorDesktop(
                                    pageController: pageController,
                                    city: city,
                                  );
                                } else {
                                  return BookmarkGestureDetectorMobile(
                                    pageController: pageController,
                                    city: city,
                                  );
                                }
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        }

        /// show Error for AllCityStatus
        if (state.getAllCityStatus is GetAllCityError) {
          /// casting for getting Error
          GetAllCityError getAllCityError =
              state.getAllCityStatus as GetAllCityError;

          return Center(
            child: Text(getAllCityError.message!),
          );
        }

        /// show Default value
        return Container();
      },
    );
  }
}
