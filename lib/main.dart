import 'package:hiit/features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:hiit/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:hiit/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/presentation/ui/main_wrapper.dart';

void main() async {
  /// init locator
  await setup();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<HomeBloc>()),
          BlocProvider(create: (_) => locator<BookmarkBloc>()),
        ],
        child: MainWrapper(),
      ),
    ),
  );
}
