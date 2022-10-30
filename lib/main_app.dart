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
    return Scaffold(
      // appBar: AppBar(title: const Text('Twenty Minute')),
      body: WindowBorder(
        color: Colors.blueGrey.shade400,
        width: 1,
        child: SafeArea(
          child: Row(
              children: [
                const Background(),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Titlebar(),
                      Flexible(
                        child: PageView(
                          controller: controller,
                          children: [
                            const Dashboard(),
                            HomeScreen(),
                            const Tasks_edit(),
                          ],
                        ),
                      ),
                      // Navigate(page: controller.page ?? 0.0),
                      // Navigate(),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
