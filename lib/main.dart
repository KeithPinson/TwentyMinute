/// Main starting point of the app.
///
/// This is broken into 3 files:
///
///               main: Persistence and initialization
///         main_shell: Visual themes and localization
///           main_app: Routing
///
/// The main_app nests inside the main_app_shell which
/// nests inside of the main file.
///
///    main.dart
///     ┗━ main_shell.dart
///         ┗━ main_app.dart
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:tekartik_app_flutter_sqflite/sqflite.dart';
import 'package:tekartik_app_platform/app_platform.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';

import 'package:twentyminute/components/bloc_observer.dart';
import 'package:twentyminute/resources/task_db_provider.dart';
import 'package:twentyminute/screens/dashboard.dart';
import 'package:twentyminute/screens/home_screen.dart';
import 'package:twentyminute/screens/tasks_edit.dart';
import 'package:twentyminute/ui/titlebar.dart';

part 'main_shell.dart';
part 'main_app.dart';


// Persistence and Initialization
// ------------------------------

late DbTaskProvider taskProvider;

Future<void> main() async {
  Routemaster.setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // Init saved theme
  final savedThemeMode = await AdaptiveTheme.getThemeMode();


  //
  // Init SQLite
  //
  var packageName = 'com.keithpinson.twentyminute';

  platformInit();  // Tekartik Sqlflite initialization for non-web platforms
  // For dev on windows, find the proper sqlite3.dll
  if (!kIsWeb) {
    sqfliteWindowsFfiInit();
  }

  var databaseFactory = getDatabaseFactory(packageName: packageName);

  taskProvider = DbTaskProvider(databaseFactory);

  await taskProvider.ready;


  //
  // Init BLOC features
  //
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );


  //
  // Run nested AppShell under BLOC
  //
  HydratedBlocOverrides.runZoned(
    () => runApp(
      AppShell(savedThemeMode: savedThemeMode),  // AppShell widget
    ),
    blocObserver: AppBlocObserver(),
    storage: storage,
  );


  //
  // Init sizes when ready
  //
  doWhenWindowReady(() {
    const initialSize = Size(312, 312);
    const maxSize = Size(640, 800);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.maxSize = maxSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}
