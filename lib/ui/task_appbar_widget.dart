/// Task Appbar Widget
///
/// Provide a way to get back to the screen.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:flutter/material.dart';
//import 'package:twentyminute/ui/theme_services.dart';
import 'package:get/get.dart';
import 'package:twentyminute/ui/theme.dart';

class TaskAppBar extends StatelessWidget with PreferredSizeWidget {
  const TaskAppBar({Key? key, this.leadingWidget}) : super(key: key);
  final Widget? leadingWidget;
  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: leadingWidget,
      // actions: [
      //   IconButton(
      //     onPressed: () {
      //       ThemeServices().switchTheme();
      //     },
      //     icon: Icon(
      //       Get.isDarkMode
      //           ? Icons.wb_sunny_outlined
      //           : Icons.nightlight_round_outlined,
      //     ),
      //     color: Get.isDarkMode ? Colors.white : darkGreyClr,
      //   )
      // ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
