import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:chatbird/src/chat_form/chat_form_view.dart';
import 'package:chatbird/src/post/post_controller.dart';
import 'package:chatbird/src/post/post_details_view.dart';
import 'package:chatbird/src/post/post_list_view.dart';
import 'package:chatbird/src/settings/settings_controller.dart';
import 'package:chatbird/src/settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  // Fields.
  final PostController postController;
  final SettingsController settingsController;

  // Constructor.
  const MyApp({
    super.key,
    required this.postController,
    required this.settingsController,
  });

  @override
  Widget build(BuildContext context) {
    // Glue the controllers to the MaterialApp.
    // The ListenableBuilder Widget listens to the controllers for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: Listenable.merge(
        <Listenable>[
          postController,
          settingsController
        ]
      ),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(
            useMaterial3: true,

            // Define the default brightness and colors.
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 204, 196, 192),
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case ChatFormView.routeName:
                    return ChatFormView(postController: postController);
                  case PostDetailsView.routeName:
                    return const PostDetailsView();
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case PostListView.routeName:
                  default:
                    return PostListView(controller: postController);
                }
              },
            );
          },
        );
      },
    );
  }
}
