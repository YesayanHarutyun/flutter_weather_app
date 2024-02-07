import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/domain/models/settings_model.dart';
import 'package:flutter_weather_app/presentation/apptheme/app_theme_provider.dart';
import 'package:flutter_weather_app/presentation/constants/constants.dart';
import 'package:flutter_weather_app/presentation/constants/strings.dart';
import 'package:flutter_weather_app/presentation/viewmodel/settings_viewmodel.dart';
import 'package:provider/provider.dart' as provider;

class SettingsScreen extends ConsumerWidget {
  SettingsScreen({super.key});

  final _settingsViewModelStateNotifierProvider =
      settingsViewModelStateNotifierProvider;

  Widget _buildWidgetState(WidgetRef ref, BuildContext context) {
    return ref.watch(_settingsViewModelStateNotifierProvider).maybeWhen(
          loading: () => _buildLoadingWidget(),
          success: (data) => _buildSuccessWidget(data, ref, context),
          error: (_) => _buildErrorWidget(ref),
          orElse: () => _buildErrorWidget(ref),
        );
  }

  Widget _buildLoadingWidget() => const Center(
        child: CircularProgressIndicator(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        backgroundColor: Colors.transparent,
        body: _buildWidgetState(ref, context),
      );

  Widget _buildSuccessWidget(
    SettingsModel settingsModel,
    WidgetRef ref,
    BuildContext context,
  ) {
    final appThemeProvider = provider.Provider.of<AppThemeProvider>(context);
    final viewModel =
        ref.read(_settingsViewModelStateNotifierProvider.notifier);
    return ListView(
      children: [
        ListTile(
          title: Text(
            Strings.darkTheme,
            style: styleOnlyWhiteColor,
          ),
          trailing: Switch(
            onChanged: (value) {
              appThemeProvider.darkTheme = value;
              viewModel.saveSelectedTheme(value);
            },
            value: appThemeProvider.darkTheme,
          ),
        ),
        const Divider(
          indent: dp_15,
          endIndent: dp_15,
        ),
        ListTile(
          title: Text(Strings.termsAndConditions, style: styleOnlyWhiteColor),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            // TODO: Navigate to the Terms & Conditions screen.
          },
        ),
        const Divider(
          indent: dp_15,
          endIndent: dp_15,
        ),
        ListTile(
          title: Text(Strings.aboutUs, style: styleOnlyWhiteColor),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            // TODO: Navigate to the About Us screen.
          },
        ),
      ],
    );
  }

  Widget _buildErrorWidget(
    WidgetRef ref,
  ) {
    final viewModel =
        ref.read(_settingsViewModelStateNotifierProvider.notifier);
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
          const SizedBox(height: dp_20), // Spacer between text and button
          ElevatedButton(
            onPressed: () async => await viewModel.getSelectedTheme(),
            child: const Text(Strings.refresh),
          ),
        ],
      ),
    );
  }
}
