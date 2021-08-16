/**
 * Copyright (c) Keith Pinson.
 *
 * A set of conditional variables the help with determining
 * our environment such as the platform in which we run.
 * Preferences are not found here.
 *
 * @see [[LICENSE]] file in the root directory of this source.
 */

//
// Platform
//

/*
 * Platform string
 *   (Unknown,Android,iOS,Windows,Mac,AppleTV,
 *    SamsungTV,SmartTVAlliance,WebOS,WearOS)
 * Platform id (0,1,2,3,4,5,6,7,8)
 */

//
// Platform Specific Flags
//

/*
 * Certain platforms have unique features we
 * may want to use. These flags, although
 * available for all platforms, are meant to
 * be unique to a a specific platform.
 */

/*
 * windowHasCustomTitlebar
 */

//
// Screen Type
//

/*
 * For the following strings translate:
 *    Wide = landscape
 *    Narrow = portrait
 *
 * ScreenType string (Unknown,PhoneNarrow,PhoneWide,TabletNarrow,TabletWide,Desktop,TV,Watch)
 * ScreenType id (0,1,2,3,4,5,6,7)
 * isLandscape
 * isPortrait
 */

//
// Screen Size
//

/*
 * Various platforms have virtual pixel sizes
 * since actual pixel sizes can vary so much
 * between models of devices. In addition, the
 * distance one is from the device effects
 * perception of size; in particular, phone to
 * desktop to TV.
 */

// import {Appearance, Platform} from 'react-native';
//const colorScheme = Appearance.getColorScheme(); // 'light' or 'dark'

//import {NativeAppEventEmitter, Platform, PlatformColor, useColorScheme} from 'react-native';
import {Platform, useColorScheme} from 'react-native';
// const colorScheme = useColorScheme(); // 'light' or 'dark'

// const platformColorScheme = PlatformColor.getColorScheme();
// const cscheme = useColorScheme();

//  isHighContrast: platformColorScheme === 'hc',
//  isColorSchemeDark: colorScheme === 'dark',

export default {
  isAndroid: Platform.OS === 'android',
  isIos: Platform.OS === 'ios',
  isWindows: Platform.OS === 'windows',
  hasCustomTitlebar: Platform.OS === 'windows',
};

/*
onAppearanceChanged = (event) => {
  const currentTheme = Appearance.currentTheme;
  this.setState({ currentTheme });
};
*/

// static addChangeListener(listener)
// static removeChangeListener(listner)
