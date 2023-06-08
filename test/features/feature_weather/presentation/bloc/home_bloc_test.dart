import 'package:flutter_test/flutter_test.dart';
import 'package:hiit/core/params/forecast_params.dart';
import 'package:hiit/core/resources/data_state.dart';
import 'package:hiit/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:hiit/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:hiit/features/feature_weather/domain/entities/forecast_hourly_entity.dart';
import 'package:hiit/features/feature_weather/domain/use_cases/get_current_weather_location_usecase.dart';
import 'package:hiit/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:hiit/features/feature_weather/domain/use_cases/get_forecast_hourly_usecase.dart';
import 'package:hiit/features/feature_weather/domain/use_cases/get_forecast_weather_usecase.dart';
import 'package:hiit/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:hiit/features/feature_weather/presentation/bloc/fh_status.dart';
import 'package:hiit/features/feature_weather/presentation/bloc/fw_status.dart';
import 'package:hiit/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:hiit/features/feature_weather/presentation/bloc/lw_status.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_bloc_test.mocks.dart';

// @GenerateNiceMocks
@GenerateMocks([
  GetCurrentWeatherUseCase,
  GetForecastWeatherUseCase,
  GetForecastHourlyUseCase,
  GetCurrentWeatherLocationUseCase,
])
void main() {
  MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase =
      MockGetCurrentWeatherUseCase();
  MockGetForecastWeatherUseCase mockGetForecastWeatherUseCase =
      MockGetForecastWeatherUseCase();
  MockGetForecastHourlyUseCase mockGetForecastHourlyUseCase =
      MockGetForecastHourlyUseCase();
  MockGetCurrentWeatherLocationUseCase mockGetCurrentWeatherLocationUseCase =
      MockGetCurrentWeatherLocationUseCase();
  String cityName = 'Tehran';
  String error = 'error';
  double lat = 35.6944;
  double lon = -51.4215;
  group(
    'cw Event test',
    () {
      when(mockGetCurrentWeatherUseCase.call(any)).thenAnswer(
          (_) async => Future.value(const DataSuccess(CurrentCityEntity())));
      when(mockGetForecastWeatherUseCase.call(any)).thenAnswer(
          (_) async => Future.value(const DataSuccess(ForecastDaysEntity())));
      when(mockGetForecastHourlyUseCase.call(any)).thenAnswer(
          (_) async => Future.value(const DataSuccess(ForecastHourlyEntity())));
      when(mockGetCurrentWeatherLocationUseCase.call(any)).thenAnswer(
          (_) async => Future.value(const DataSuccess(CurrentCityEntity())));

      blocTest<HomeBloc, HomeState>(
        'emit loading and completed CW state',
        build: () => HomeBloc(
          mockGetCurrentWeatherUseCase,
          mockGetForecastWeatherUseCase,
          mockGetForecastHourlyUseCase,
          mockGetCurrentWeatherLocationUseCase,
        ),
        act: (bloc) {
          bloc.add(LoadCwEvent(cityName));
        },
        expect: () => <HomeState>[
          HomeState(
            cwStatus: CwLoading(),
            fwStatus: FwLoading(),
            fhStatus: FhLoading(),
            lwStatus: LwInitial(),
          ),
          HomeState(
            cwStatus: CwCompleted(const CurrentCityEntity()),
            fwStatus: FwLoading(),
            fhStatus: FhLoading(),
            lwStatus: LwInitial(),
          ),
        ],
      );

      test('emit Loading and Error CW state', () {
        when(mockGetCurrentWeatherUseCase.call(any))
            .thenAnswer((_) async => Future.value(DataFailed(error)));

        final bloc = HomeBloc(
          mockGetCurrentWeatherUseCase,
          mockGetForecastWeatherUseCase,
          mockGetForecastHourlyUseCase,
          mockGetCurrentWeatherLocationUseCase,
        );
        bloc.add(LoadCwEvent(cityName));

        expectLater(
            bloc.stream,
            emitsInOrder([
              HomeState(
                cwStatus: CwLoading(),
                fwStatus: FwLoading(),
                fhStatus: FhLoading(),
                lwStatus: LwInitial(),
              ),
              HomeState(
                cwStatus: CwError(error),
                fwStatus: FwLoading(),
                fhStatus: FhLoading(),
                lwStatus: LwInitial(),
              ),
            ]));
      });

      blocTest<HomeBloc, HomeState>(
        'emit loading and completed FW state',
        build: () => HomeBloc(
          mockGetCurrentWeatherUseCase,
          mockGetForecastWeatherUseCase,
          mockGetForecastHourlyUseCase,
          mockGetCurrentWeatherLocationUseCase,
        ),
        act: (bloc) {
          // bloc.add(LoadCwEvent(cityName));
          final ForecastParams forecastParams = ForecastParams(lat, lon);
          bloc.add(LoadFwEvent(forecastParams));
        },
        expect: () => <HomeState>[
          HomeState(
            cwStatus: CwLoading(),
            fwStatus: FwLoading(),
            fhStatus: FhLoading(),
            lwStatus: LwInitial(),
          ),
          // HomeState(
          //   cwStatus: CwCompleted(const CurrentCityEntity()),
          //   fwStatus: FwLoading(),
          //   fhStatus: FhLoading(),
          //   lwStatus: LwInitial(),
          // ),
          HomeState(
            // cwStatus: CwCompleted(const CurrentCityEntity()),
            cwStatus: CwLoading(),
            fwStatus: FwCompleted(const ForecastDaysEntity()),
            fhStatus: FhLoading(),
            lwStatus: LwInitial(),
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emit loading and completed FH state',
        build: () => HomeBloc(
          mockGetCurrentWeatherUseCase,
          mockGetForecastWeatherUseCase,
          mockGetForecastHourlyUseCase,
          mockGetCurrentWeatherLocationUseCase,
        ),
        act: (bloc) {
          final ForecastParams forecastParams = ForecastParams(lat, lon);
          bloc.add(LoadFhEvent(forecastParams));
        },
        expect: () => <HomeState>[
          HomeState(
            cwStatus: CwLoading(),
            fwStatus: FwLoading(),
            fhStatus: FhLoading(),
            lwStatus: LwInitial(),
          ),
          HomeState(
            cwStatus: CwLoading(),
            fwStatus: FwLoading(),
            fhStatus: FhCompleted(const ForecastHourlyEntity()),
            lwStatus: LwInitial(),
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emit loading and completed LW state',
        build: () => HomeBloc(
          mockGetCurrentWeatherUseCase,
          mockGetForecastWeatherUseCase,
          mockGetForecastHourlyUseCase,
          mockGetCurrentWeatherLocationUseCase,
        ),
        act: (bloc) {
          final ForecastParams forecastParams = ForecastParams(lat, lon);
          bloc.add(LoadLwEvent(forecastParams));
        },
        expect: () => <HomeState>[
          HomeState(
            cwStatus: CwLoading(),
            fwStatus: FwLoading(),
            fhStatus: FhLoading(),
            lwStatus: LwLoading(),
          ),
          HomeState(
            cwStatus: CwLoading(),
            fwStatus: FwLoading(),
            fhStatus: FhLoading(),
            lwStatus: LwCompleted(const CurrentCityEntity()),
          ),
          HomeState(
            cwStatus: CwCompleted(const CurrentCityEntity()),
            fwStatus: FwLoading(),
            fhStatus: FhLoading(),
            lwStatus: LwCompleted(const CurrentCityEntity()),
          ),
        ],
      );
    },
  );
}
