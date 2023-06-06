import 'package:hiit/core/params/forecast_params.dart';
import 'package:hiit/core/presentation/widgets/dot_loading_widget.dart';
import 'package:hiit/core/utils/date_converter.dart';
import 'package:hiit/core/utils/prefs_operator.dart';
import 'package:hiit/features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:hiit/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:hiit/features/feature_weather/domain/use_cases/get_suggestion_city_usecase.dart';
import 'package:hiit/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:hiit/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:hiit/features/feature_weather/presentation/widgets/bookmark_icon.dart';
import 'package:hiit/features/feature_weather/presentation/widgets/current_weather_view.dart';
import 'package:hiit/features/feature_weather/presentation/widgets/days_weather_view.dart';
import 'package:hiit/features/feature_weather/presentation/widgets/hourly_weather_view.dart';
import 'package:hiit/features/feature_weather/presentation/widgets/location_icon.dart';
import 'package:hiit/features/feature_weather/presentation/widgets/propertly_weather_view.dart';
import 'package:hiit/features/feature_weather/presentation/widgets/search_box_view.dart';
import 'package:hiit/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static int page = 0;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController();
  TextEditingController textEditingController = TextEditingController();

  GetSuggestionCityUseCase getSuggestionCityUseCase =
      GetSuggestionCityUseCase(locator());
  String cityName = 'Tehran';

  Future<void> _refreshCurrentWeather() async {
    /// get city name selected
    PrefsOperator prefsOperator = locator();
    var cityNameSelected = await prefsOperator.getCitySelected();

    BlocProvider.of<HomeBloc>(context).add(
      LoadCwEvent(cityNameSelected ?? cityName),
    );
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(cityName));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return RefreshIndicator(
      backgroundColor: Colors.transparent,
      color: Colors.amber,
      onRefresh: _refreshCurrentWeather,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// text field suggestion city name
            SizedBox(height: height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(
                children: [
                  /// current location icon
                  LocationIcon(cityName: cityName),

                  const SizedBox(width: 10),

                  /// search box
                  SearchBoxView(
                    textEditingController: textEditingController,
                    getSuggestionCityUseCase: getSuggestionCityUseCase,
                  ),

                  const SizedBox(width: 10),

                  /// bookmark icon city
                  BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) {
                      if (previous.cwStatus == current.cwStatus) {
                        return false;
                      }
                      return true;
                    },
                    builder: (context, state) {
                      /// show Loading State for Cw
                      if (state.cwStatus is CwLoading) {
                        return const DotLoadingWidget();
                      }

                      /// show Error State for Cw
                      if (state.cwStatus is CwError) {
                        return IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("please load a city!"),
                                behavior:
                                    SnackBarBehavior.floating, // Add this line
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.error,
                            color: Colors.white,
                            size: 35,
                          ),
                        );
                      }

                      if (state.cwStatus is CwCompleted) {
                        final CwCompleted cwComplete =
                            state.cwStatus as CwCompleted;
                        BlocProvider.of<BookmarkBloc>(context).add(
                          GetCityByNameEvent(
                              cwComplete.currentCityEntity.name!),
                        );
                        return BookMarkIcon(
                          name: cwComplete.currentCityEntity.name!,
                        );
                      }

                      return Container();
                    },
                  ),
                ],
              ),
            ),

            /// main UI
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) {
                /// rebuild just when CwStatus Changed
                if (previous.cwStatus == current.cwStatus) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                if (state.cwStatus is CwLoading) {
                  return const Expanded(
                    child: DotLoadingWidget(),
                  );
                }

                if (state.cwStatus is CwCompleted) {
                  /// cast
                  final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
                  final CurrentCityEntity currentCityEntity =
                      cwCompleted.currentCityEntity;

                  /// create params for api call
                  final ForecastParams forecastParams = ForecastParams(
                    currentCityEntity.coord!.lat!,
                    currentCityEntity.coord!.lon!,
                  );

                  /// start load Fw event
                  BlocProvider.of<HomeBloc>(context).add(
                    LoadFwEvent(forecastParams),
                  );

                  /// start load Fh event
                  BlocProvider.of<HomeBloc>(context).add(
                    LoadFhEvent(forecastParams),
                  );

                  /// change Times to Hour --5:55 AM/PM----
                  final sunrise = DateConverter.changeDtToDateTimeHour(
                    currentCityEntity.sys!.sunrise,
                    currentCityEntity.timezone,
                  );
                  final sunset = DateConverter.changeDtToDateTimeHour(
                    currentCityEntity.sys!.sunset,
                    currentCityEntity.timezone,
                  );

                  return Expanded(
                    child: ListView(
                      children: [
                        /// page view touch drift
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.02),
                          child: SizedBox(
                            width: width,
                            height: 370,
                            child: PageView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              allowImplicitScrolling: true,
                              controller: _pageController,
                              itemCount: 2,
                              itemBuilder: (context, position) {
                                if (position == 0) {
                                  CurrentWeatherView(
                                    currentCityEntity: currentCityEntity,
                                  );
                                } else {
                                  /// forecast weather 48 hourly
                                  HourlyWeatherView(
                                    forecastParams: forecastParams,
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),
                        ),

                        Center(
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: 2,
                            effect: const ExpandingDotsEffect(
                              dotWidth: 10,
                              dotHeight: 10,
                              spacing: 5,
                              activeDotColor: Colors.white,
                            ),
                            onDotClicked: (index) =>
                                _pageController.animateToPage(
                              index,
                              duration: const Duration(microseconds: 500),
                              curve: Curves.bounceOut,
                            ),
                          ),
                        ),

                        /// divider
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            color: Colors.white24,
                            height: 2,
                            width: double.infinity,
                          ),
                        ),

                        /// forecast weather 7 days
                        const DaysWeatherView(),

                        /// divider
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(
                            color: Colors.white24,
                            height: 2,
                            width: double.infinity,
                          ),
                        ),

                        const SizedBox(height: 15),

                        /// last row propertly weather
                        PropertlyWeatherView(
                          currentCityEntity: currentCityEntity,
                          sunrise: sunrise,
                          sunset: sunset,
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  );
                }

                if (state.cwStatus is CwError) {
                  return const Center(
                    child: Text('Error'),
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
