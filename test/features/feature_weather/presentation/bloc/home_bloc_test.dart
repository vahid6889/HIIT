import 'package:flutter_test/flutter_test.dart';
import 'package:Hiit/core/params/forecast_params.dart';
import 'package:Hiit/core/resources/data_state.dart';
import 'package:Hiit/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:Hiit/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:Hiit/features/feature_weather/domain/entities/forecast_hourly_entity.dart';
import 'package:Hiit/features/feature_weather/domain/use_cases/get_current_air_quality_city_usecase.dart';
import 'package:Hiit/features/feature_weather/domain/use_cases/get_current_weather_location_usecase.dart';
import 'package:Hiit/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:Hiit/features/feature_weather/domain/use_cases/get_forecast_hourly_usecase.dart';
import 'package:Hiit/features/feature_weather/domain/use_cases/get_forecast_weather_usecase.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/aq_status.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/fh_status.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/fw_status.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/lw_status.dart';
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
  GetCurrentAirQualityCityUsecase,
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
  MockGetCurrentAirQualityCityUsecase mockGetCurrentAirQualityCityUsecase =
      MockGetCurrentAirQualityCityUsecase();
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
          mockGetCurrentAirQualityCityUsecase,
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
            aqStatus: AqLoading(),
          ),
          HomeState(
            cwStatus: CwCompleted(const CurrentCityEntity()),
            fwStatus: FwLoading(),
            fhStatus: FhLoading(),
            lwStatus: LwInitial(),
            aqStatus: AqLoading(),
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
          mockGetCurrentAirQualityCityUsecase,
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
                aqStatus: AqLoading(),
              ),
              HomeState(
                cwStatus: CwError(error),
                fwStatus: FwLoading(),
                fhStatus: FhLoading(),
                lwStatus: LwInitial(),
                aqStatus: AqLoading(),
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
          mockGetCurrentAirQualityCityUsecase,
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
            aqStatus: AqLoading(),
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
            aqStatus: AqLoading(),
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
          mockGetCurrentAirQualityCityUsecase,
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
            aqStatus: AqLoading(),
          ),
          HomeState(
            cwStatus: CwLoading(),
            fwStatus: FwLoading(),
            fhStatus: FhCompleted(const ForecastHourlyEntity()),
            lwStatus: LwInitial(),
            aqStatus: AqLoading(),
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
          mockGetCurrentAirQualityCityUsecase,
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
            aqStatus: AqLoading(),
          ),
          HomeState(
            cwStatus: CwLoading(),
            fwStatus: FwLoading(),
            fhStatus: FhLoading(),
            lwStatus: LwCompleted(const CurrentCityEntity()),
            aqStatus: AqLoading(),
          ),
          HomeState(
            cwStatus: CwCompleted(const CurrentCityEntity()),
            fwStatus: FwLoading(),
            fhStatus: FhLoading(),
            lwStatus: LwCompleted(const CurrentCityEntity()),
            aqStatus: AqLoading(),
          ),
        ],
      );
    },
  );
}
