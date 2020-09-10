import {Appearance, Platform} from 'react-native';

const colorScheme = Appearance.getColorScheme(); // 'light' or 'dark'

export default {
  isColorSchemeDark: colorScheme === 'dark',
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
