/// Replacement Title Bar
///
///   Rather than using using the api to change the window title bar,
///   we hide the title bar and create our own.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class Titlebar extends WindowTitleBarBox {
  final Widget? child;
  Titlebar({Key? key, this.child}) : super(key: key);

  bool isDesktop() {
    bool isDesktop = false;

    if (!kIsWeb &&
        (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      isDesktop = true;
    }

     return isDesktop;
  }


  @override
  Widget build(BuildContext context) {

    if (!isDesktop()) {
      return Container(height: 0);
    }

    final titlebarHeight = appWindow.titleBarHeight;
    return SizedBox(
        height: titlebarHeight,
        child: Row(
          children: [
            Expanded(child:MoveWindow()),
            const WindowButtons()
          ]
        )
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  _WindowButtonsState createState() => _WindowButtonsState();
}


class RestoreWindowButton extends WindowButton {
  RestoreWindowButton(
      {Key? key,
        WindowButtonColors? colors,
        VoidCallback? onPressed,
        bool? animate})
      : super(
      key: key,
      colors: colors,
      animate: animate ?? false,
      iconBuilder: (buttonContext) =>
          RestoreIcon(color: buttonContext.iconColor),
      onPressed: onPressed ?? () => appWindow.maximizeOrRestore());
}


class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        appWindow.isMaximized ? RestoreWindowButton(
          colors: buttonColors,
          onPressed: maximizeOrRestore,
        ) : MaximizeWindowButton(
          colors: buttonColors,
          onPressed: maximizeOrRestore,
        ),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
