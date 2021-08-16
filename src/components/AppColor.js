/**
 * Copyright (c) Keith Pinson.
 *
 * Standard app colors.
 *
 * @see [[LICENSE]] file in the root directory of this source.
 */

/*
 *
 * Requirements:
 *
 * - Support dynamic change of color modes, ie. Dark switching to Light switching to HC Light, etc.
 * - Hight contrast colors for background and bodyText have a contrast ratio over 7:1
 * - Hight contrast colors for background and headerText have a contrast ratio over 4.5:1
 *
 * Color Labels:
 *
 *   background
 *   faceMedium
 *   faceLow
 *   headerText
 *   subheaderText
 *   titleText
 *   subtitleText
 *   faceText
 *   disabledText
 *   bodyText
 *   captionText
 *   accentHigh
 *   accentMedium
 *   accentLow
 *
 * For every Color Label there is a Color Mode of:
 *
 * - Dark
 * - Light
 * - HC Dark
 * - HC Light
 *
 * For every Color Mode there is Platform Color for at least:
 *
 * - Android
 * - iOS
 * - Windows
 *
 */

import Environment from './Environment';

('use strict');

// prettier-ignore
const AppColor = {
  isDarkMode: false,
  isHcMode: false,

  scheme(colorScheme) {
    if (colorScheme === 'dark') {
      this.isDarkMode = true;
    } else if (colorScheme === 'light') {
      this.isHcMode = false;
    }
  },

  highContrastOn(turnOn) {
    this.isHcMode = turnOn;
  },

  background() {
    // prettier-ignore
    const darkBackground =
        Environment.isAndroid ? 'rgba(36,39,38,0.3)'
      : Environment.isIos     ? 'rgba(36,39,38,0.3)'
      : Environment.isWindows ? {windowsbrush: 'WindowBrushDark'}
      :                         'rgba(36,39,38,0.3)';

    const lightBackground =
        Environment.isAndroid ? 'rgba(247,249,249,0.3)'
      : Environment.isIos     ? 'rgba(247,249,249,0.3)'
      : Environment.isWindows ? {windowsbrush: 'WindowBrushLight'}
      :                         'rgba(247,249,249,0.3)';

    const hcDarkBackground =
        Environment.isAndroid ? '#010101'
      : Environment.isIos     ? '#010101'
      : Environment.isWindows ? {windowsbrush: 'WindowBrushHCDark'}
      :                         '#010101';

    const hcLightBackground =
        Environment.isAndroid ? '#FEFEFE'
      : Environment.isIos     ? '#FEFEFE'
      : Environment.isWindows ? {windowsbrush: 'WindowBrushHCLight'}
      :                         '#FEFEFE';

    const backgroundColor =
      this.isDarkMode ?
          this.isHcMode ? hcDarkBackground : darkBackground
        : this.isHcMode ? hcLightBackground : lightBackground;

    return backgroundColor;
  },

  faceMedium() {
    /*
     *     darkFaceMedium
     *     lightFaceMedium
     *     hcDarkFaceMedium
     *     hcLightFaceMedium
     */
    return '#FEFEFE';
  },
  faceLow() {
    /*
     *     darkFaceLow
     *     lightFaceLow
     *     hcDarkFaceLow
     *     hcLightFaceLow
     */
    return '#FEFEFE';
  },
  headerText() {
    /*
     *     darkHeaderText
     *     lightHeaderText
     *     hcDarkHeaderText
     *     hcLightHeaderText
     */
    return '#010101';
  },
  subheaderText() {
    /*
     *     darkSubheaderText
     *     lightSubheaderText
     *     hcDarkSubheaderText
     *     hcLightSubheaderText
     */
    return '#010101';
  },
  titleText() {
    /*
     *     darkTitleText
     *     lightTitleText
     *     hcDarkTitleText
     *     hcLightTitleText
     */
    return '#010101';
  },
  subtitleText() {
    /*
     *     darkSubtitleText
     *     lightSubtitleText
     *     hcDarkSubtitleText
     *     hcLightSubtitleText
     */
    return '#010101';
  },
  faceText() {
    /*
     *     darkFaceText
     *     lightFaceText
     *     hcDarkFaceText
     *     hcLightFaceText
     */
    return '#010101';
  },
  disabledText() {
    /*
     *     darkDisabledText
     *     lightDisabledText
     *     hcDarkDisabledText
     *     hcLightDisabledText
     */
    return '#010101';
  },
  bodyText() {
    // prettier-ignore
    const darkBodyText =
        Environment.isAndroid ? 'rgb(242,242,242)'
      : Environment.isIos     ? 'rgb(242,242,242)'
      : Environment.isWindow  ? {windowsbrush: 'WindowTextBrushDark'}
      :                         'rgb(242,242,242)';

    const lightBodyText =
        Environment.isAndroid ? 'rgba(247,249,249,0.3)'
      : Environment.isIos     ? 'rgba(247,249,249,0.3)'
      : Environment.isWindows ? {windowsbrush: 'WindowTextBrushLight'}
      :                         'rgba(247,249,249,0.3)';

    const hcDarkBodyText =
        Environment.isAndroid ? '#010101'
      : Environment.isIos     ? '#010101'
      : Environment.isWindows ? {windowsbrush: 'WindowTextBrushHCDark'}
      :                         '#010101';

    const hcLightBodyText =
        Environment.isAndroid ? '#FEFEFE'
      : Environment.isIos     ? '#FEFEFE'
      : Environment.isWindows ? {windowsbrush: 'WindowTextBrushHCLight'}
      :                         '#FEFEFE';

    const bodyTextColor =
      this.isDarkMode ?
          this.isHcMode ? hcDarkBodyText : darkBodyText
        : this.isHcMode ? hcLightBodyText : lightBodyText;

    return bodyTextColor;
  },
  captionText() {
    // prettier-ignore
    const darkCaptionText =
        Environment.isAndroid ? 'rgb(242,242,242)'
      : Environment.isIos     ? 'rgb(242,242,242)'
      : Environment.isWindow  ? {windowsbrush: 'ElementTextBrushDark'}
      :                         'rgb(242,242,242)';

    const lightCaptionText =
        Environment.isAndroid ? 'rgb(23,23,23)'
      : Environment.isIos     ? 'rgb(23,23,23)'
      : Environment.isWindows ? {windowsbrush: 'ElementTextBrushLight'}
      :                         'rgb(23,23,23)';

    const hcDarkCaptionText =
        Environment.isAndroid ? '#010101'
      : Environment.isIos     ? '#010101'
      : Environment.isWindows ? {windowsbrush: 'ElementTextBrushHCDark'}
      :                         '#010101';

    const hcLightCaptionText =
        Environment.isAndroid ? '#FEFEFE'
      : Environment.isIos     ? '#FEFEFE'
      : Environment.isWindows ? {windowsbrush: 'ElementTextBrushHCLight'}
      :                         '#FEFEFE';

    const captionTextColor =
      this.isDarkMode ?
          this.isHcMode ? hcDarkCaptionText : darkCaptionText
        : this.isHcMode ? hcLightCaptionText : lightCaptionText;

    return captionTextColor;
  },
  accentHigh() {
    // prettier-ignore
    const darkAccentHigh =
        Environment.isAndroid ? 'rgb(20,153,240)'
      : Environment.isIos     ? 'rgb(20,153,240)'
      : Environment.isWindow  ? {windowsbrush: 'ElementAccentHighBrushDark'}
      :                         'rgba(51,153,255,204)';

    const lightAccentHigh =
        Environment.isAndroid ? 'rgb(18,146,180)'
      : Environment.isIos     ? 'rgb(18,146,180)'
      : Environment.isWindows ? {windowsbrush: 'ElementAccentHighBrushLight'}
      :                         'rgba(15,109,168,204)';

    const hcDarkAccentHigh =
        Environment.isAndroid ? '#010101'
      : Environment.isIos     ? '#010101'
      : Environment.isWindows ? {windowsbrush: 'ElementAccentHighBrushHCDark'}
      :                         '#010101';

    const hcLightAccentHigh =
        Environment.isAndroid ? '#FEFEFE'
      : Environment.isIos     ? '#FEFEFE'
      : Environment.isWindows ? {windowsbrush: 'ElementAccentHighBrushHCLight'}
      :                         '#FEFEFE';

    const accentHighColor =
      this.isDarkMode ?
          this.isHcMode ? hcDarkAccentHigh : darkAccentHigh
        : this.isHcMode ? hcLightAccentHigh : lightAccentHigh;

    return accentHighColor;
  },
  accentLow() {
    // prettier-ignore
    const darkAccentLow =
        Environment.isAndroid ? 'rgb(18,146,180)'
      : Environment.isIos     ? 'rgb(18,146,180)'
      : Environment.isWindow  ? {windowsbrush: 'ElementAccentLowBrushDark'}
      :                        'rgba(51,153,255,204)';

    const lightAccentLow =
        Environment.isAndroid ? 'rgb(18,146,180)'
      : Environment.isIos     ? 'rgb(18,146,180)'
      : Environment.isWindows ? {windowsbrush: 'ElementAccentLowBrushLight'}
      :                         'rgba(51,153,255,204)';

    const hcDarkAccentLow =
        Environment.isAndroid ? '#010101'
      : Environment.isIos     ? '#010101'
      : Environment.isWindows ? {windowsbrush: 'ElementAccentLowBrushHCDark'}
      :                         '#010101';

    const hcLightAccentLow =
        Environment.isAndroid ? '#FEFEFE'
      : Environment.isIos     ? '#FEFEFE'
      : Environment.isWindows ? {windowsbrush: 'ElementAccentLowBrushHCLight'}
      :                         '#FEFEFE';

    const accentLowColor =
      this.isDarkMode ?
          this.isHcMode ? hcDarkAccentLow : darkAccentLow
        : this.isHcMode ? hcLightAccentLow : lightAccentLow;

    return accentLowColor;
  },
};

module.exports = AppColor;
