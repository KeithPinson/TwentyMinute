/// This App Shell is part of the Main starting point of the app.
///
/// Here we define a stateless widget shell that controls aspects
/// of the entire app, including:
///
///      - light/dark/high-contrast
///      - locale/region
///      - Material/Cupertino/Other UI wrapper
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

part of 'main.dart';


// Visual Themes and Localization
// ------------------------------


//
// App Shell Widget
//
@immutable
class AppShell extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;  // adaptive_theme for dynamic day/night theme support

  AppShell({Key? key, this.savedThemeMode}) : super(key: key);

  final timerBloc = TimerBloc(
    ticks: const TimeTicks(),
    durationSeconds: Preference.duration,
  );

  late final activeTaskBloc = ActiveTaskBloc(
    timerBloc: timerBloc,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TimerBloc>(
          create: (BuildContext context) => timerBloc,
        ),
        BlocProvider<ActiveTaskBloc>(
          create: (BuildContext context) => activeTaskBloc,
        ),
        BlocProvider<TaskBloc>(
          create: (BuildContext context) => TaskBloc(),
        ),
        BlocProvider<TallyMarksBloc>(
          create: (BuildContext context) => TallyMarksBloc(activeTaskBloc: activeTaskBloc),
        ),
        BlocProvider<AlertBloc>(
          create: (BuildContext context) => AlertBloc(timerBloc: timerBloc),
        ),
      ],
/*
      child: MultiRepositoryProvider(
        providers: [
          // RepositoryProvider(
          //   create: (context) => _authenticationRepository,
          // ),
          RepositoryProvider(
            create: (context) => TaskController(),
          ),
        ],
        child: const HomeScreenView(),
      ),
*/
      child: MaterialApp(
        title: 'Twenty Minute',
        debugShowCheckedModeBanner: false,
        home: App(),
      )
    );

    // return AdaptiveTheme(
    //   light: ThemeData.light().copyWith(
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   dark: ThemeData.dark().copyWith(
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   initial: savedThemeMode ?? AdaptiveThemeMode.light,
    //
      // builder: (light, dark) => MaterialApp.router(
      //   title: 'Twenty Minute',
      //   theme: light,
      //   darkTheme: dark,
      //   debugShowCheckedModeBanner: false,
      //   routerDelegate: routemasterDelegate,
      //   routeInformationParser: const RoutemasterParser(),
      //   // home: App(),
      // ),
    // );
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


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


final customWidth01 =
CustomSliderWidths(trackWidth: 2, progressBarWidth: 10, shadowWidth: 20);
final customColors01 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.8),
    trackColor: HexColor('#FFD4BE').withOpacity(0.4),
    progressBarColor: HexColor('#F6A881'),
    shadowColor: HexColor('#FFD4BE'),
    shadowStep: 10.0,
    shadowMaxOpacity: 0.6);

final CircularSliderAppearance appearance01 = CircularSliderAppearance(
    customWidths: customWidth01,
    customColors: customColors01,
    startAngle: 270,
    angleRange: 360,
    size: 350.0,
    animationEnabled: false);

final customWidth02 =
CustomSliderWidths(trackWidth: 5, progressBarWidth: 15, shadowWidth: 30);
final customColors02 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.8),
    trackColor: HexColor('#98DBFC').withOpacity(0.3),
    progressBarColor: HexColor('#6DCFFF'),
    shadowColor: HexColor('#98DBFC'),
    shadowStep: 15.0,
    shadowMaxOpacity: 0.3);

final CircularSliderAppearance appearance02 = CircularSliderAppearance(
    customWidths: customWidth02,
    customColors: customColors02,
    startAngle: 270,
    angleRange: 360,
    size: 290.0,
    animationEnabled: false);

final customWidth03 =
CustomSliderWidths(trackWidth: 8, progressBarWidth: 20, shadowWidth: 40);
final customColors03 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.8),
    trackColor: HexColor('#EFC8FC').withOpacity(0.3),
    progressBarColor: HexColor('#A177B0'),
    shadowColor: HexColor('#EFC8FC'),
    shadowStep: 20.0,
    shadowMaxOpacity: 0.3);

final CircularSliderAppearance appearance03 = CircularSliderAppearance(
    customWidths: customWidth03,
    customColors: customColors03,
    startAngle: 270,
    angleRange: 360,
    size: 210.0,
    animationEnabled: false);

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white70,
            Colors.blueGrey.shade100,
          ],
        ),
      ),
    );
  }
}
