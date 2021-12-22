/// Preference Resources
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:shared_preferences/shared_preferences.dart';

class Preference{

  static SharedPreferences? preferences;
  static  intial() async{
    preferences =  await SharedPreferences.getInstance();
  }
  static Future<bool> put({required String key,required bool value})
  async {
    return  await preferences!.setBool(key, value);
  }
  static bool? get({required String key})
  {
    return   preferences!.getBool(key);
  }
}
