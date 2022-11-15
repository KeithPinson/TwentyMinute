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
      Stack( children: [
      const Background(),
      SafeArea( child:
        Column( children: [
          WindowTitlebar(),
          Expanded(
              child:
            PageView( controller: controller,
                      children: const [
              Tasks_edit(),
              HomeScreen(),
              Dashboard(),
            ]),
          ),
          Container(
              decoration: BoxDecoration(color:Colors.grey.shade300),
              child:
            Container(height:40)
            // Navigate(page: 1.0)
          ),
        ]),
        ),
      ])
    );
  }
}
