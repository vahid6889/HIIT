import 'package:bloc/bloc.dart';
import 'package:hiit/core/params/forecast_params.dart';
import 'package:hiit/core/resources/data_state.dart';
import 'package:hiit/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:hiit/features/feature_weather/domain/use_cases/get_forecast_weather_usecase.dart';
import 'package:hiit/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:hiit/features/feature_weather/presentation/bloc/fw_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  final GetForecastWeatherUseCase _getForecastWeatherUseCase;

  HomeBloc(this.getCurrentWeatherUseCase, this._getForecastWeatherUseCase)
      : super(HomeState(cwStatus: CwLoading(), fwStatus: FwLoading())) {
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
  }
}
