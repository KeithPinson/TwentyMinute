/// Main starting point of the app.
///
///   This is the root of the widget tree. We define it as a
///   stateless widget shell that incorporates controls that
///   affect the entire app, including:
///
///      - light/dark/high-contrast
///      - locale/region
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:window_manager/window_manager.dart';
import 'package:tekartik_app_flutter_sqflite/sqflite.dart';
import 'package:tekartik_app_platform/app_platform.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:twentyminute/resources/preferences.dart';
import 'package:twentyminute/screens/home_screen.dart';
import 'package:twentyminute/ui/titlebar.dart';
import 'package:twentyminute/components/timer_bloc.dart';
import 'package:twentyminute/components/bloc_observer.dart';
import 'package:twentyminute/resources/time_ticks.dart';
// import 'package:twentyminute/components/theme_cubit.dart';
// import 'package:twentyminute/resources/preferences.dart';
import 'package:twentyminute/components/theme_cubit.dart';
import 'package:twentyminute/resources/task_db_provider.dart';



/// Note for localization:
///
/// To add supported locales to `ios/Runner/Info.plist`
///
///     <dict>
///       <key>CFBundleLocalizations</key>
///       <array>
///     	  <string>en</string>           <-- Locale added
///       </array>
///       ...
///     </dict>

late DbTaskProvider taskProvider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //
  // Desktop Support
  //
  // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //
  // LaunchAtStartup.instance.setup(
  //   appName: packageInfo.appName,
  //   appPath: Platform.resolvedExecutable,
  // );
  //
  // await LaunchAtStartup.instance.enable();
  // await LaunchAtStartup.instance.disable();
  // bool isEnabled = await LaunchAtStartup.instance.isEnabled();
  //
  // // Support for AlwaysOnTop
  //
  // await windowManager.ensureInitialized();
  // Use it only after calling `hiddenWindowAtLaunch`
  // windowManager.waitUntilReadyToShow().then((_) async{
  //   // Set to frameless window
  //   await windowManager.setAsFrameless();
  //   await windowManager.setSize(Size(300, 600));
  //   await windowManager.setPosition(Offset.zero);
  //   windowManager.show();
  // });


  // await EasyLocalization.ensureInitialized();

  // Use this if the Android frame rate issue returns...
  //
  // if (Platform.isAndroid) {
  //   await FlutterDisplayMode.setHighRefreshRate();
  // }
  //

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  final savedThemeMode = await AdaptiveTheme.getThemeMode();


  platformInit();
  // For dev on windows, find the proper sqlite3.dll
  if (!kIsWeb) {
    sqfliteWindowsFfiInit();
  }
  var packageName = 'com.keithpinson.twentyminute';

  var databaseFactory = getDatabaseFactory(packageName: packageName);

  taskProvider = DbTaskProvider(databaseFactory);

  await taskProvider.ready;


  // await GetStorage.init();

  // Bloc will be used for managing application state
  //
  HydratedBlocOverrides.runZoned(
    () => runApp(
  //     EasyLocalization(
  //       path: 'assets/i18n',
  //       supportedLocales: const [
  //         Locale('en', 'US'),
  //       ],
  //       fallbackLocale: const Locale('en', 'US'),
  //       useFallbackTranslations: true,
      AppShell(savedThemeMode: savedThemeMode),
    ),
    blocObserver: AppBlockObserver(),
    storage: storage,
  );

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

@immutable
class AppShell extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const AppShell({Key? key, this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      dark: ThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (light, dark) => GetMaterialApp(
        title: 'Twenty Minute',
        theme: light,
        darkTheme: dark,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // appBar: AppBar(title: const Text('Twenty Minute')),
          body: WindowBorder(
            color: Colors.blueGrey.shade400,
            width: 1,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Titlebar(),
                      const HomeScreen(),
                    ],
                  ),
                ),
              ]
            )
          )
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     theme: ThemeData(
  //         brightness: Brightness.dark,
  //         primaryColor: Colors.blueGrey
  //     ),
  //     useInheritedMediaQuery: true,
  //
  //     home: BlocProvider(
  //       create: (_) => TimerBloc(ticks: TimeTicks()),
  //       child: const HomeScreen(),
  //     ),
  //   );
  // }
}
