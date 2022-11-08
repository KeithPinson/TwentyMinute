/// As part of Main, this is a nested widget of AppShell.
///
/// Here we layout the core UI and support routing to
/// the screens of the app.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

part of 'main.dart';


// Routing and Core UI
// -------------------

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final controller = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold( body:
      SafeArea( child:
        Stack( children: [
          const Background(),
          Titlebar(),
          PageView( controller: controller,
                    children: [
            const Tasks_edit(),
            HomeScreen(),
            const Dashboard(),
          ])
        ])
      ),
    );
  }
}
