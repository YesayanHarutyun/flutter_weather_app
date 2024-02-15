import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/data/datasource/sharedpereferences/shared_preferences_manager_impl.dart';
import 'package:flutter_weather_app/domain/sharedpreferences/shared_preferences_manager.dart';
import 'package:flutter_weather_app/presentation/apptheme/app_theme_provider.dart';
import 'package:provider/provider.dart' as as_provider;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_weather_app/domain/models/weather_model_wrapper.dart';
import 'package:flutter_weather_app/presentation/constants/constants.dart';
import 'package:flutter_weather_app/presentation/constants/strings.dart';
import 'package:flutter_weather_app/presentation/view/weather_detalis_screen.dart';
import 'package:flutter_weather_app/presentation/viewmodel/home_screen_viewmodel.dart';
import 'package:flutter_weather_app/presentation/viewmodel/weather_details_viewmodel.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final _homeViewModelProvider = homeViewModelStateNotifierProvider;
  final SharedPreferencesManager preferencesManager = SharedPreferencesManagerImpl();

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: _buildWidgetState(ref, context),
      );

  Widget _buildWidgetState(WidgetRef ref, BuildContext context) =>
      ref.watch(_homeViewModelProvider).maybeWhen(
            loading: () => _buildLoadingWidget(),
            success: (data) => _buildSuccessWidget(data, ref, context),
            error: (_) => _buildErrorWidget(ref),
            orElse: () => _buildErrorWidget(ref),
          );

  Widget _buildLoadingWidget() => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildSuccessWidget(
    WeatherModelWrapper weatherModelWrapper,
    WidgetRef ref,
    BuildContext context,
  ) {
    final appThemeProvider = as_provider.Provider.of<AppThemeProvider>(context);
    return RefreshIndicator(
      onRefresh: () async => ref
          .read(_homeViewModelProvider.notifier)
          .fetchWeatherByCity(false, weatherModelWrapper.weatherModel.city),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: dp_50),
            child: Column(
              children: [
                _buildSearch(ref),
                _buildCityInfo(weatherModelWrapper, appThemeProvider.darkTheme,
                    ref, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearch(WidgetRef ref) {
    final viewModel = ref.read(_homeViewModelProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(left: dp_20, right: dp_20),
      child: TypeAheadField(
        debounceDuration: const Duration(milliseconds: durationWithMillis300),
        getImmediateSuggestions: false,
        textFieldConfiguration: TextFieldConfiguration(
          style: styleOnlyWhiteColor,
          autofocus: true,
          decoration: InputDecoration(
            hintText: Strings.searchCity,
            hintStyle: styleOnlyWhiteColor,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            border: const OutlineInputBorder(),
          ),
        ),
        suggestionsBoxDecoration: const SuggestionsBoxDecoration(
          color: Colors.white12,
        ),
        suggestionsCallback: (suggestedKeyWord) async {
          return await viewModel.fetchAutocompleteSearchCity(suggestedKeyWord);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            tileColor: Colors.black45,
            title: Text(
              suggestion.citySuggestion,
              style: styleOnlyWhiteColor,
            ),
            onTap: () {
              viewModel.fetchWeatherByCity(false, suggestion.citySuggestion);
            },
          );
        },
        onSuggestionSelected: (suggestion) {},
      ),
    );
  }

  Widget _buildCityInfo(
    WeatherModelWrapper weatherModelWrapper,
    bool isDarkMode,
    WidgetRef ref,
    BuildContext context,
  ) {
    final viewModel = ref.read(_homeViewModelProvider.notifier);
    return GestureDetector(
      onTap: () {
        ref.read(cityNameProvider.notifier).state =
            weatherModelWrapper.weatherModel.city;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeatherDetailsScreen(
              cityName: weatherModelWrapper.weatherModel.city,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: dp_20, right: dp_20, top: dp_150),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(dp_30),
          ),
          gradient: isDarkMode
              ? weatherItemDarkModeGradient
              : weatherItemLightModeGradient,
        ),
        padding: const EdgeInsets.all(dp_20),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  weatherModelWrapper.weatherModel.city,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize20),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    weatherModelWrapper.weatherModel.isFavourite
                        ? await viewModel.deleteFavouriteCity(
                            weatherModelWrapper.weatherModel)
                        : await viewModel
                            .addFavouriteCity(weatherModelWrapper.weatherModel);
                    viewModel.getFavouriteCities();
                  },
                  icon: weatherModelWrapper.weatherModel.isFavourite
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                ),
              ],
            ),
            Image.network(
              weatherModelWrapper.weatherModel.icon,
              fit: BoxFit.cover,
              width: dp_100,
              height: dp_80,
            ),
            Text(
              "${weatherModelWrapper.weatherModel.temperatureC.toString()}${Strings.celsius}",
              style: f52RWhiteRoboto,
            ),
            Row(
              children: [
                Text(
                  weatherModelWrapper.weatherModel.description,
                  style: f16RWhiteRoboto,
                ),
                const Spacer(),
                Text(
                  "${Strings.windDirection} '${weatherModelWrapper.weatherModel.windDir}'",
                  style: f16RWhiteRoboto,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(WidgetRef ref) {
    final viewModel = ref.read(_homeViewModelProvider.notifier);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            Strings.somethingWentWrong,
            style: TextStyle(
              fontSize: dp_24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: dp_20),
          ElevatedButton(
            onPressed: () async {
              final currentCityName = await preferencesManager.getCurrentCity();
              viewModel.fetchWeatherByCity(true, currentCityName ?? "");
            },
            child: const Text(Strings.refresh),
          ),
        ],
      ),
    );
  }
}
