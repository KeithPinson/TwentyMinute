/// Theme Cubit
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:flutter/material.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:twentyminute/ui/theme.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState(AppThemes.lightTheme));

  void getTheme(ThemeState state) {
    emit(state);
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return json['isDark'] as bool
        ? ThemeState(AppThemes.darkTheme)
        : ThemeState(AppThemes.lightTheme);
  }

  @override
  Map<String, bool>? toJson(ThemeState state) {
    return {'isDark': state.themeData.brightness == Brightness.dark};
  }
}
