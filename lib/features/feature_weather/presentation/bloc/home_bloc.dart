import 'package:bloc/bloc.dart';
import 'package:hiit/core/params/forecast_params.dart';
import 'package:hiit/core/resources/data_state.dart';
import 'package:hiit/features/feature_weather/domain/use_cases/get_current_weather_location_usecase.dart';
import 'package:hiit/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:hiit/features/feature_weather/domain/use_cases/get_forecast_hourly_usecase.dart';
import 'package:hiit/features/feature_weather/domain/use_cases/get_forecast_weather_usecase.dart';
import 'package:hiit/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:hiit/features/feature_weather/presentation/bloc/fh_status.dart';
import 'package:hiit/features/feature_weather/presentation/bloc/fw_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hiit/features/feature_weather/presentation/bloc/lw_status.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  final GetForecastWeatherUseCase _getForecastWeatherUseCase;
  final GetForecastHourlyUseCase _getForecastHourlyUseCase;
  final GetCurrentWeatherLocationUseCase getCurrentWeatherLocationUseCase;

  HomeBloc(
    this.getCurrentWeatherUseCase,
    this._getForecastWeatherUseCase,
    this._getForecastHourlyUseCase,
    this.getCurrentWeatherLocationUseCase,
  ) : super(
          HomeState(
            cwStatus: CwLoading(),
            fwStatus: FwLoading(),
            fhStatus: FhLoading(),
            lwStatus: LwInitial(),
          ),
        ) {
    on<LoadCwEvent>(
      (event, emit) async {
        emit(state.copyWith(newCwStatus: CwLoading()));

        DataState dataState = await getCurrentWeatherUseCase(event.cityName);

        if (dataState is DataSuccess) {
          emit(state.copyWith(newCwStatus: CwCompleted(dataState.data)));
        }

        if (dataState is DataFailed) {
          emit(state.copyWith(newCwStatus: CwError(dataState.error!)));
        }
      },
    );

    /// load current weather location for city Event
    on<LoadLwEvent>(
      (event, emit) async {
        /// emit State to Loading for Lw and CW
        emit(state.copyWith(newLwStatus: LwLoading()));
        emit(state.copyWith(newCwStatus: CwLoading()));

        DataState dataState =
            await getCurrentWeatherLocationUseCase(event.forecastParams);

        /// emit State to Complete for Lw and CW
        if (dataState is DataSuccess) {
          emit(state.copyWith(newLwStatus: LwCompleted(dataState.data)));
          emit(state.copyWith(newCwStatus: CwCompleted(dataState.data)));
        }

        /// emit State to Error for just FW
        if (dataState is DataFailed) {
          emit(state.copyWith(newLwStatus: LwError(dataState.error!)));
          emit(state.copyWith(newCwStatus: CwError(dataState.error!)));
        }
      },
    );

    /// load 7 days Forcast weather for city Event
    on<LoadFwEvent>(
      (event, emit) async {
        /// emit State to Loading for just FW
        emit(state.copyWith(newFwStatus: FwLoading()));

        DataState dataState =
            await _getForecastWeatherUseCase(event.forecastParams);

        /// emit State to Complete for just FW
        if (dataState is DataSuccess) {
          emit(state.copyWith(newFwStatus: FwCompleted(dataState.data)));
        }

        /// emit State to Error for just FW
        if (dataState is DataFailed) {
          emit(state.copyWith(newFwStatus: FwError(dataState.error!)));
        }
      },
    );

    /// load 48 hourly Forcast weather for city Event
    on<LoadFhEvent>(
      (event, emit) async {
        /// emit State to Loading for just FW
        emit(state.copyWith(newFhStatus: FhLoading()));

        DataState dataState =
            await _getForecastHourlyUseCase(event.forecastParams);

        /// emit State to Complete for just FW
        if (dataState is DataSuccess) {
          emit(state.copyWith(newFhStatus: FhCompleted(dataState.data)));
        }

        /// emit State to Error for just FW
        if (dataState is DataFailed) {
          emit(state.copyWith(newFhStatus: FhError(dataState.error!)));
        }
      },
    );
  }
}
