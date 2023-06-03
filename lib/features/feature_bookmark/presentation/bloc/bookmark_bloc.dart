import 'package:bloc/bloc.dart';
import 'package:hiit/core/resources/data_state.dart';
import 'package:hiit/core/usecase/use_case.dart';
import 'package:hiit/features/feature_bookmark/domain/use_cases/delete_city_usecase.dart';
import 'package:hiit/features/feature_bookmark/domain/use_cases/get_all_city_usecase.dart';
import 'package:hiit/features/feature_bookmark/domain/use_cases/get_city_usecase.dart';
import 'package:hiit/features/feature_bookmark/domain/use_cases/save_city_usecase.dart';
import 'package:hiit/features/feature_bookmark/presentation/bloc/delete_city_status.dart';
import 'package:hiit/features/feature_bookmark/presentation/bloc/get_all_city_status.dart';
import 'package:hiit/features/feature_bookmark/presentation/bloc/get_city_status.dart';
import 'package:hiit/features/feature_bookmark/presentation/bloc/save_city_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  GetCityUseCase getCityUseCase;
  SaveCityUseCase saveCityUseCase;
  GetAllCityUseCase getAllCityUseCase;
  DeleteCityUseCase deleteCityUseCase;

  BookmarkBloc(
    this.getCityUseCase,
    this.saveCityUseCase,
    this.getAllCityUseCase,
    this.deleteCityUseCase,
  ) : super(
          BookmarkState(
            getCityStatus: GetCityLoading(),
            saveCityStatus: SaveCityInitial(),
            getAllCityStatus: GetAllCityLoading(),
            deleteCityStatus: DeleteCityInitial(),
          ),
        ) {
    /// City Delete Event
    on<DeleteCityEvent>((event, emit) async {
      /// emit Loading state
      emit(state.copyWith(newDeleteCityStatus: DeleteCityLoading()));

      DataState dataState = await deleteCityUseCase(event.name);

      /// emit Complete state
      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newDeleteCityStatus: DeleteCityCompleted(dataState.data),
          ),
        );
      }

      /// emit Error state
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newDeleteCityStatus: DeleteCityError(dataState.error),
          ),
        );
      }
    });

    /// get All city
    on<GetAllCityEvent>((event, emit) async {
      /// emit Loading state
      emit(state.copyWith(newGetAllCityStatus: GetAllCityLoading()));

      DataState dataState = await getAllCityUseCase(NoParams());

      /// emit Complete state
      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newGetAllCityStatus: GetAllCityCompleted(dataState.data),
          ),
        );
      }

      /// emit Error state
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newGetAllCityStatus: GetAllCityError(dataState.error),
          ),
        );
      }
    });

    /// get city By name event
    on<GetCityByNameEvent>((event, emit) async {
      /// emit Loading state
      emit(state.copyWith(newGetCityStatus: GetCityLoading()));

      DataState dataState = await getCityUseCase(event.cityName);

      /// emit Complete state
      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newGetCityStatus: GetCityCompleted(dataState.data),
          ),
        );
      }

      /// emit Error state
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newGetCityStatus: GetCityError(dataState.error),
          ),
        );
      }
    });

    /// Save City Event
    on<SaveCwEvent>((event, emit) async {
      /// emit Loading state
      emit(
        state.copyWith(
          newSaveCityStatus: SaveCityLoading(),
        ),
      );

      DataState dataState = await saveCityUseCase(event.name);

      /// emit Complete state
      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newSaveCityStatus: SaveCityCompleted(dataState.data),
          ),
        );
      }

      /// emit Error state
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newSaveCityStatus: SaveCityError(dataState.error),
          ),
        );
      }
    });

    /// set to init again SaveCity (برای بار دوم و سوم و غیره باید وضعیت دوباره به حالت اول برگرده وگرنه بوکمارک پر خواهد ماند)
    on<SaveCityInitialEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            newSaveCityStatus: SaveCityInitial(),
          ),
        );
      },
    );
  }
}