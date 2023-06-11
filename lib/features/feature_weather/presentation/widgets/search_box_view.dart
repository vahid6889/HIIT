import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:Hiit/core/utils/prefs_operator.dart';
import 'package:Hiit/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:Hiit/features/feature_weather/domain/use_cases/get_suggestion_city_usecase.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:Hiit/locator.dart';

class SearchBoxView extends StatelessWidget {
  final TextEditingController textEditingController;
  final GetSuggestionCityUseCase getSuggestionCityUseCase;
  const SearchBoxView({
    super.key,
    required this.textEditingController,
    required this.getSuggestionCityUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          onSubmitted: (String prefix) {
            textEditingController.text = prefix;
            BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(prefix));
          },
          controller: textEditingController,
          style: DefaultTextStyle.of(context).style.copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            hintText: "Enter a City...",
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        suggestionsCallback: (String prefix) {
          return getSuggestionCityUseCase(prefix);
        },
        itemBuilder: (context, Data model) {
          return ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(model.name!),
            subtitle: Text("${model.region!}, ${model.country!}"),
          );
        },
        onSuggestionSelected: (Data model) {
          /// save city name selected
          PrefsOperator prefsOperator = locator();
          prefsOperator.saveCitySelected(model.name!);

          textEditingController.text = model.name!;
          BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(model.name!));
        },
      ),
    );
  }
}
