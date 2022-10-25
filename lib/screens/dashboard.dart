/// Dashboard of completed tasks
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Text('Dashboard'),
      ),
    );
  }
}
