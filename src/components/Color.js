/**
 * Copyright (c) Keith Pinson.
 *
 * Globally defined colors.
 *
 * @see [[LICENSE]] file in the root directory of this source.
 */

import PlatformTheme from '../components/Theme';

//
// Every color has a dark, light, and hc (high-contrast) variant.
//
export default {
  darkBackground: PlatformTheme.isAndroid
    ? 'rgba(36,39,38,0.3)'
    : PlatformTheme.isIos
    ? 'rgba(36,39,38,0.3)'
    : PlatformTheme.isWindows
    ? {windowsbrush: 'WindowBrushDark'}
    : 'rgba(36,39,38,0.3)',
  lightBackground: PlatformTheme.isAndroid
    ? 'rgba(247,249,249,0.3)'
    : PlatformTheme.isIos
    ? 'rgba(247,249,249,0.3)'
    : PlatformTheme.isWindows
    ? {windowsbrush: 'WindowBrushLight'}
    : 'rgba(247,249,249,0.3)',
  hcBackground: PlatformTheme.isAndroid
    ? '#FFFFFF'
    : PlatformTheme.isIos
    ? '#FFFFFF'
    : PlatformTheme.isWindows
    ? {windowsbrush: 'WindowBrushHighContrast'}
    : '#FFFFFF',
  darkFaceMedium: PlatformTheme.isWindows
    ? {windowsbrush: 'WindowFaceBrushDark'}
    : '#2B2B2B',
  lightFaceMedium: PlatformTheme.isWindows
    ? {windowsbrush: 'WindowFaceBrushLight'}
    : '#F2F2F2',
  hcFaceMedium: PlatformTheme.isWindows
    ? {windowsbrush: 'WindowTextBrushDark'}
    : '#F2F2F2',
  darkFaceLow: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementFaceBrushDark'}
    : '#2B2B2B',
  lightFaceLow: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementFaceBrushLight'}
    : '#F2F2F2',
  hcFaceLow: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementFaceBrushHighContrast'}
    : '#F2F2F2',
  darkHeaderText: PlatformTheme.isWindows
    ? {windowsbrush: 'WindowTextBrushDark'}
    : '#F2F2F2',
  lightHeaderText: PlatformTheme.isWindows
    ? {windowsbrush: 'WindowTextBrushLight'}
    : '#171717',
  hcHeaderText: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementTextBrushHighContrast'}
    : '#171717',
  darkSubheaderText: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementTextBrushDark'}
    : '#F2F2F2',
  lightSubheaderText: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementTextBrushLight'}
    : '#171717',
  hcSubheaderText: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementAccentHighBrushHighContrast'}
    : '#CC3399FF',
  darkTitleText: '#F2F2F2',
  lightTitleText: '#171717',
  hcTitleText: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementAccentHighBrushHighContrast'}
    : '#CC3399FF',
  darkSubtitleText: '#F2F2F2',
  lightSubtitleText: '#171717',
  hcSubtitleText: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementAccentHighBrushHighContrast'}
    : '#CC3399FF',
  darkFaceText: '#F2F2F2',
  lightFaceText: '#171717',
  hcFaceText: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementAccentHighBrushHighContrast'}
    : '#CC3399FF',
  darkDisabledText: '#F2F2F2',
  lightDisabledText: '#171717',
  hcDisabledText: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementAccentHighBrushHighContrast'}
    : '#CC3399FF',
  darkBodyText: '#F2F2F2',
  lightBodyText: '#171717',
  hcBodyText: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementAccentHighBrushHighContrast'}
    : '#CC3399FF',
  darkCaptionText: '#F2F2F2',
  lightCaptionText: '#171717',
  hcCaptionText: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementAccentHighBrushHighContrast'}
    : '#CC3399FF',
  darkAccentHigh: '#1292B4',
  lightAccentHigh: '#1292B4',
  hcAccentHigh: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementAccentHighBrushHighContrast'}
    : '#CC3399FF',
  darkAccentMedium: '#1292B4',
  hcAccentMedium: '#1292B4',
  lightAccentLow: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementAccentLowBrushHighContrast'}
    : '#33FFFFFF',
  darkAccentLow: '#1292B4',
  lightAccentMedium: '#1292B4',
  hcAccentLow: PlatformTheme.isWindows
    ? {windowsbrush: 'ElementAccentLowBrushHighContrast'}
    : '#33FFFFFF',
};
