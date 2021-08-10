# Developer Notes

[TOC]

## Step 0: Confirm Windows Dependencies

We are using VScode to build windows app. It will require Visual Studio be installed with Desktop C++ (we are using C# but the libraries are written in C++) and UWP.

From an elevated Powershell:

```powershell
Set-ExecutionPolicy Unrestricted -Scope Process -Force; iex (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/microsoft/react-native-windows/master/vnext/Scripts/rnw-dependencies.ps1')
```

Install the missing pieces when prompted (If running a newer version of Node it may need to be uninstalled and a Node LTS version installed in its place.)

**Visual Studio Installer**

Even though we are using VScode, React-native-windows relies on the installation of Visual Studio. Microsoft seems to use a hodge-podge of SDKs and Toolsets in its `node_models/react-native-windows` folder. Start _Visual Studio Install_ and under "Individual components" confirm the installation of:

- Windows 10 SDK 10.0.18362.1
- Windows 10 SDK 10.0.19041.0
- Windows 10 SDK 10.0.20348.0 (May be installed but not listed)
- MSVC v140 - VS 2015 C++ build tools
- MSVC v141 - VS 2017 C++ x64/x86 build tools
- MSVC v142 - VS 2019 C++ x64/x86 build tools

| Windows 10 SDK |            |
| -------------- | ---------- |
| 10.0.18362.1   | March 2019 |
| 10.0.19041.0   | April 2020 |
| 10.0.20348.0   | April 2021 |

| MSVC toolset |                                             |
| ------------ | ------------------------------------------- |
| 14.00.xxxxx  | MSVC v140 - VS 2015 C++ build tools         |
| 14.16.27023  | MSVC v141 - VS 2017 C++ x64/x86 build tools |
| 14.29.30037  | MSVC v142 - VS 2019 C++ x64/x86 build tools |

On the left, under "Installation Details" scroll down to the "Universal Windows Platform development" section and make sure, under optional the following 2 versions are checked:

- C++ (v142) Universal Windows Platform tools
- C++ (v141) Universal Windows Platform tools

**Failing Builds**

Confirm the environment variable is set correctly:

```bash
echo %VCToolsVersion%
```

To help narrow down the failure, run:

```bash
npx react-native run-windows --logging
```

## Step 1: Building From Scratch

To build a blank **React Native for Windows** app from scratch:

```bash
> npx react-native init twentyminute --title TwentyMinute
> cd TwentyMinute
> npx react-native-windows-init --overwrite --language "cs" --useWinUI3
> code .
>
> # See:
> #  https://github.com/react-native-community/cli/blob/master/docs/commands.md
> #  https://microsoft.github.io/react-native-windows/docs/getting-started
```

> Note: This shows a flag for `useWinUI3`, which as of May 2021 is a pre-release and is not compatible with the desktop app. If used it will crash when the `titleBar` colors are set.

The message: `npx react-native run-windows` will encourage you to run the app – **DO NOT DO THIS**. Debugging with VSCode can be very difficult to get working after running the CLI script.

In the `package.json` remove the scripts that contain "react-native" (delete the whole line).

```json
"scripts": {
    "android": "react-native run-android",   <= Delete
    "ios": "react-native run-ios",           <= Delete
    "start": "react-native start",           <= Delete
    "test": "jest",
    "lint": "eslint .",
    "windows": "react-native run-windows"    <= Delete
  },
```

The VS Code, `launch.json` file will need to be added in the `.vscode` folder. It should contain (the "run debug icon" in the leftmost column to get a quick link) :

```json
{
  "configurations": [
    {
      "name": "Debug Windows",
      "cwd": "${workspaceFolder}",
      "type": "reactnative",
      "request": "launch",
      "platform": "windows"
    }
  ]
}
```

Press `F5` to launch the app.

## Step 2: Install the Dependencies

The Tables of Dependencies is listed below.

Individual packages can be added from the command prompt, for example:

```bash
yarn add --tilde @react-native-community/hooks
```

> Note: Expect React-native-windows to break every time Microsoft releases another version. It is very important to pin down everything.
>
> The semver of "react-native-windows": "^0.64.0-0" should be changed to the working version number, for example: "0.64.11".

Run `yarn install --check-cache` to check the dependencies in the `node_modules` folder.

Autolink the native modules that are being referenced, like async-storage:

```bash
> npx react-native autolink-windows --check --logging  # Shows what will be linked
> npx react-native autolink-windows                    # Performs the autolink
```

## Step 3: Check Windows 10 Version

To build and test RNW (React Native Windows) apps we need minimum version of Windows. RNW requires Windows 10 build 10586. Additionally, to make use of all the Windows features that we use, Windows 10 build 15063 is required.

```bash
>systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
```

## Step 4: Windows -- Update Icons

All of the icons in the

`windows\twentyminute\Assets\`

folder should be replaced the custom logo or icon.

At a minimum, change

- SplashScreen.scale-200.png
- Square44x44Logo.targetsize-24_altform-unplated.png

To avoid problems (DO NOT change default names)

## Step 5: Windows -- App Window Size

Microsoft has been working on RNW since at least 2016. At one time, even though RNW can make apps for the desktop, they thought RNW apps should only open full screen like on a phone. They were quite adamant about this. At some point things changed and we can now resize the app to be a sensible size, but they don't make it easy and we have to do it ourselves.

### <u>App.xaml.cs File</u>

Copy the code commented with:

- "Added to adjust app dimensions" (2 blocks of code)
- "Check for minimum required Windows 10 version"

## Step 6: Windows -- Transparency

To support translucent window when active we need to add some code and a bunch of colors with an alpha setting.

We don't want to copy whole files since MS often changes these files and we have to insert our code into theirs…_I guess when you have to eat your own dogfood it is easy to forget others have to eat it too._

### <u>App.xaml.cs File</u>

From a previous working version, copy the code with the comments:

- "Added for transparent titlebar" (2 blocks of code)

### <u>App.xaml File</u>

Add the transparent colors to the XML file.

Replace:

```xml
<Application.Resources>
    <XamlControlsResources xmlns="using:Microsoft.UI.Xaml.Controls" />
</Application.Resources>
```

With:

```xml
<Application.Resources>
    <ResourceDictionary>
        <ResourceDictionary.MergedDictionaries>
            <XamlControlsResources xmlns="using:Microsoft.UI.Xaml.Controls" />
            <!--
                Ideally a file of common styles such as
                <ResourceDictionary Source="///style/CommonStyles.xaml"/>
                should be used but am unable to get it working at this time
-->
            <ResourceDictionary>

                <!--
                       - Note: Windows Xaml uses aRGB format (alpha leads the RGB, in js it follows)
                     -->

                    <!-- Light Mode Colors -->
                    <Color x:Key="BackgroundLight">#FFF2F2F2</Color>          <!-- #F2F2F2 -->
                    <Color x:Key="FaceALight">#FFF2F2F2</Color>
                    <Color x:Key="FaceBLight">#FFE6E6E6</Color>
                    <Color x:Key="FaceCLight">#FFCCCCCC</Color>
                    <Color x:Key="TextLight">#FF171717</Color>
                    <Color x:Key="TextALight">#FF171717</Color>
                    <Color x:Key="TextBLight">#FF171717</Color>
                    <Color x:Key="TextCLight">#FF171717</Color>
                    <Color x:Key="DisabledFaceLight">#FF7A7A7A</Color>
                    <Color x:Key="DisabledTextLight">#FFCCCCCC</Color>
                    <Color x:Key="Accent10GrayLight">#19000000</Color>
                    <Color x:Key="Accent20GrayLight">#33000000</Color>
                    <Color x:Key="AccentColorLowLight">#663399FF</Color>
                    <Color x:Key="AccentColorMediumLight">#993399FF</Color>
                    <Color x:Key="AccentColorHighLight">#823399FF</Color>

                    <!-- Dark Mode Colors -->
                    <Color x:Key="BackgroundDark">#FF171717</Color>
                    <Color x:Key="FaceADark">#FF2B2B2B</Color>
                    <Color x:Key="FaceBDark">#FF1F1F1F</Color>
                    <Color x:Key="FaceCDark">#FF767676</Color>
                    <Color x:Key="TextDark">#FFF2F2F2</Color>
                    <Color x:Key="TextADark">#FFF2F2F2</Color>
                    <Color x:Key="TextBDark">#FFF2F2F2</Color>
                    <Color x:Key="TextCDark">#FFF2F2F2</Color>
                    <Color x:Key="DisabledFaceDark">#FF858585</Color>
                    <Color x:Key="DisabledTextDark">#FF333333</Color>
                    <Color x:Key="Accent10GrayDark">#19FFFFFF</Color>
                    <Color x:Key="Accent20GrayDark">#33FFFFFF</Color>
                    <Color x:Key="AccentColorLowDark">#993399FF</Color>
                    <Color x:Key="AccentColorMediumDark">#CC3399FF</Color>
                    <Color x:Key="AccentColorHighDark">#E53399FF</Color>

                    <!-- Shades of Black -->
                    <Color x:Key="Color10Black">#19000000</Color>
                    <Color x:Key="Color20Black">#33000000</Color>
                    <Color x:Key="Color40Black">#66000000</Color>
                    <Color x:Key="Color80Black">#99000000</Color>
                    <Color x:Key="ColorBlack">#FF000000</Color>

                    <!-- High Contrast Light -->
                    <Color x:Key="HCButtonFaceLight">#FF0F0F0F</Color>          <!-- #0F0F0F -->
                    <Color x:Key="HCButtonTextLight">#FFFFFFFF</Color>          <!-- #FFFFFF -->
                    <Color x:Key="HCDisabledTextLight">#FF6D6D6D</Color>        <!-- #6D6D6D -->
                    <Color x:Key="HCSelectedTextLight">#FFFFFFFF</Color>        <!-- #FFFFFF -->
                    <Color x:Key="HCSelectedBackgroundLight">#FF3399FF</Color>  <!-- #3399FF -->
                    <Color x:Key="HCHyperlinkLight">#FF0066CC</Color>           <!-- #0066CC -->
                    <Color x:Key="HCBackgroundLight">#FFFFFFFF</Color>          <!-- #FFFFFF -->
                    <Color x:Key="HCTextLight">#FF000000</Color>                <!-- #000000 -->

                    <!-- High Contrast Dark -->
                    <Color x:Key="HCButtonFaceDark">#FFFDFDFD</Color>           <!-- #FDFDFD -->
                    <Color x:Key="HCButtonTextDark">#FF000000</Color>           <!-- #000000 -->
                    <Color x:Key="HCDisabledTextDark">#FFADADAD</Color>         <!-- #ADADAD -->
                    <Color x:Key="HCSelectedTextDark">#FF000000</Color>         <!-- #000000 -->
                    <Color x:Key="HCSelectedBackgroundDark">#FF3399FF</Color>   <!-- #3399FF -->
                    <Color x:Key="HCHyperlinkDark">#FF0066CC</Color>            <!-- #0066CC -->
                    <Color x:Key="HCBackgroundDark">#FF000000</Color>           <!-- #000000 -->
                    <Color x:Key="HCTextDark">#FFFFFFFF</Color>                 <!-- #FFFFFF -->

                    <!-- Brushes -->
                    <AcrylicBrush x:Key="WindowBrushLight" BackgroundSource="HostBackdrop" FallbackColor="{ThemeResource BackgroundLight}" TintColor="{ThemeResource BackgroundLight}" TintOpacity="0.1"/>
                    <AcrylicBrush x:Key="WindowFaceBrushLight" BackgroundSource="HostBackdrop" FallbackColor="{ThemeResource FaceALight}" TintColor="{ThemeResource FaceALight}" TintOpacity="0.1"/>
                    <AcrylicBrush x:Key="WindowTextBrushLight" BackgroundSource="HostBackdrop" FallbackColor="{ThemeResource TextLight}" TintColor="{ThemeResource TextLight}" TintOpacity="0.8"/>
                    <AcrylicBrush x:Key="WindowAccentLowBrushLight" BackgroundSource="HostBackdrop" FallbackColor="{ThemeResource Accent20GrayLight}" TintColor="{ThemeResource Accent20GrayLight}" TintOpacity="0.1"/>
                    <AcrylicBrush x:Key="WindowAccentHightBrushLight" BackgroundSource="HostBackdrop" FallbackColor="{ThemeResource AccentColorMediumLight}" TintColor="{ThemeResource AccentColorMediumLight}" TintOpacity="0.1"/>
                    <AcrylicBrush x:Key="ElementBrushLight" BackgroundSource="Backdrop" FallbackColor="{ThemeResource BackgroundLight}" TintColor="{ThemeResource BackgroundLight}" TintOpacity="0.8"/>
                    <AcrylicBrush x:Key="ElementFaceBrushLight" BackgroundSource="Backdrop" FallbackColor="{ThemeResource FaceALight}" TintColor="{ThemeResource FaceALight}" TintOpacity="0.8"/>
                    <AcrylicBrush x:Key="ElementTextBrushLight" BackgroundSource="Backdrop" FallbackColor="{ThemeResource TextLight}" TintColor="{ThemeResource TextLight}" TintOpacity="0.8"/>
                    <AcrylicBrush x:Key="ElementDisabledTextBrushLight" BackgroundSource="Backdrop" FallbackColor="{ThemeResource DisabledTextLight}" TintColor="{ThemeResource DisabledTextLight}" TintOpacity="0.8"/>
                    <AcrylicBrush x:Key="ElementAccentLowBrushLight" BackgroundSource="Backdrop" FallbackColor="{ThemeResource Accent20GrayLight}" TintColor="{ThemeResource Accent20GrayLight}" TintOpacity="0.8"/>
                    <AcrylicBrush x:Key="ElementAccentHightBrushLight" BackgroundSource="Backdrop" FallbackColor="{ThemeResource AccentColorMediumLight}" TintColor="{ThemeResource AccentColorMediumLight}" TintOpacity="0.8"/>

                    <AcrylicBrush x:Key="WindowBrushDark" BackgroundSource="HostBackdrop" FallbackColor="{ThemeResource BackgroundDark}" TintColor="{ThemeResource BackgroundDark}" TintOpacity="0.1"/>
                    <AcrylicBrush x:Key="WindowFaceBrushDark" BackgroundSource="HostBackdrop" FallbackColor="{ThemeResource FaceADark}" TintColor="{ThemeResource FaceADark}" TintOpacity="0.1"/>
                    <AcrylicBrush x:Key="WindowTextBrushDark" BackgroundSource="HostBackdrop" FallbackColor="{ThemeResource TextDark}" TintColor="{ThemeResource TextDark}" TintOpacity="0.1"/>
                    <AcrylicBrush x:Key="WindowAccentLowBrushDark" BackgroundSource="HostBackdrop" FallbackColor="{ThemeResource Accent20GrayDark}" TintColor="{ThemeResource Accent20GrayDark}" TintOpacity="0.1"/>
                    <AcrylicBrush x:Key="WindowAccentHightBrushDark" BackgroundSource="HostBackdrop" FallbackColor="{ThemeResource AccentColorMediumDark}" TintColor="{ThemeResource AccentColorMediumDark}" TintOpacity="0.1"/>
                    <AcrylicBrush x:Key="ElementBrushDark" BackgroundSource="Backdrop" FallbackColor="{ThemeResource BackgroundDark}" TintColor="{ThemeResource BackgroundDark}" TintOpacity="0.8"/>
                    <AcrylicBrush x:Key="ElementFaceBrushDark" BackgroundSource="Backdrop" FallbackColor="{ThemeResource FaceADark}" TintColor="{ThemeResource FaceADark}" TintOpacity="0.8"/>
                    <AcrylicBrush x:Key="ElementTextBrushDark" BackgroundSource="Backdrop" FallbackColor="{ThemeResource TextDark}" TintColor="{ThemeResource TextDark}" TintOpacity="0.8"/>
                    <AcrylicBrush x:Key="ElementDisabledTextBrushDark" BackgroundSource="Backdrop" FallbackColor="{ThemeResource DisabledTextDark}" TintColor="{ThemeResource DisabledTextDark}" TintOpacity="0.8"/>
                    <AcrylicBrush x:Key="ElementAccentLowBrushDark" BackgroundSource="Backdrop" FallbackColor="{ThemeResource Accent20GrayDark}" TintColor="{ThemeResource Accent20GrayDark}" TintOpacity="0.8"/>
                    <AcrylicBrush x:Key="ElementAccentHightBrushDark" BackgroundSource="Backdrop" FallbackColor="{ThemeResource AccentColorMediumDark}" TintColor="{ThemeResource AccentColorMediumDark}" TintOpacity="0.8"/>

                    <SolidColorBrush x:Key="WindowBrushHCLight" Color="{ThemeResource HCBackgroundLight}" />
                    <SolidColorBrush x:Key="WindowFaceBrushHCLight" Color="{ThemeResource HCButtonFaceLight}" />
                    <SolidColorBrush x:Key="WindowTextBrushHCLight" Color="{ThemeResource HCTextLight}" />
                    <SolidColorBrush x:Key="WindowAccentLowBrushHCLight" Color="{ThemeResource Accent20GrayLight}" />
                    <SolidColorBrush x:Key="WindowAccentHightBrushHCLight" Color="{ThemeResource AccentColorMediumLight}" />
                    <SolidColorBrush x:Key="ElementBrushHCLight" Color="{ThemeResource BackgroundLight}" />
                    <SolidColorBrush x:Key="ElementFaceBrushHCLight" Color="{ThemeResource FaceALight}" />
                    <SolidColorBrush x:Key="ElementTextBrushHCLight" Color="{ThemeResource TextLight}" />
                    <SolidColorBrush x:Key="ElementDisabledTextBrushHCLight" Color="{ThemeResource HCDisabledTextLight}" />
                    <SolidColorBrush x:Key="ElementAccentLowBrushHCLight" Color="{ThemeResource Accent20GrayLight}" />
                    <SolidColorBrush x:Key="ElementAccentHightBrushHCLight" Color="{ThemeResource AccentColorMediumLight}" />

                    <SolidColorBrush x:Key="WindowBrushHCDark" Color="{ThemeResource HCBackgroundDark}" />
                    <SolidColorBrush x:Key="WindowFaceBrushHCDark" Color="{ThemeResource HCButtonFaceDark}" />
                    <SolidColorBrush x:Key="WindowTextBrushHCDark" Color="{ThemeResource HCTextDark}" />
                    <SolidColorBrush x:Key="WindowAccentLowBrushHCDark" Color="{ThemeResource Accent20GrayDark}" />
                    <SolidColorBrush x:Key="WindowAccentHightBrushHCDark" Color="{ThemeResource AccentColorMediumDark}" />
                    <SolidColorBrush x:Key="ElementBrushHCDark" Color="{ThemeResource BackgroundDark}" />
                    <SolidColorBrush x:Key="ElementFaceBrushHCDark" Color="{ThemeResource FaceADark}" />
                    <SolidColorBrush x:Key="ElementTextBrushHCDark" Color="{ThemeResource TextDark}" />
                    <SolidColorBrush x:Key="ElementDisabledTextBrushHCDark" Color="{ThemeResource HCDisabledTextDark}" />
                    <SolidColorBrush x:Key="ElementAccentLowBrushHCDark" Color="{ThemeResource Accent20GrayDark}" />
                    <SolidColorBrush x:Key="ElementAccentHightBrushHCDark" Color="{ThemeResource AccentColorMediumDark}" />

            </ResourceDictionary>
        </ResourceDictionary.MergedDictionaries>
    </ResourceDictionary>
</Application.Resources>
```

After the `backgroundColor` is set to use the Windows Brush, the app will use the Acrylic style while the app window is active.

## Step 7: Windows -- Always On Top Button

To add a button on the Title Bar which toggles the App so it is always on top, change the following

### Expand into Title Bar

### Title Bar Icons

#### <u>Assets</u>

#### <u>C# Project File</u>

`*\windows\TwentyMinute\TwentyMinute.csproj`

Copy the pattern of the icons and add the png files.

- Always on top icon, "TwentyMinute_OnTopIcon.png"
- Not, always on top icon, "TwentyMinute_OffTopIcon.png"

## \*fixed\* Flow

If you are getting ,an error message about flow versions, try: `yarn upgrade flow-bin`

Unless things have been fixed this will not work.

Instead: change the `[version]` to `^0.107.0` in the '.flowconfig' file.

---

## Updating Yarn Itself

```bash
> yarn policies set-version
> npm install --global yarn
```

## Getting Yarn Started

```bash
yarn set version berry # Yarn 2
yarn init # Run this after cloning a project with a package.json file
```

## Pinning Dependencies

- Add package with `–exact` or `–tilde` parameter, or
- Replace any carets with tildes in package.json, eg. ^1.0.0 becomes ~1.0.0
- Make all version changes through the PR (pull request) process
- Do not run `yarn up`

## Dependencies

---

Example of how to add package, `yarn add --tilde react`

---

| Dependency                                | Version | Why we are Adding                  |
| ----------------------------------------- | ------- | ---------------------------------- |
| react                                     |         | from boilerplate                   |
| react-native                              |         | from boilerplate                   |
| react-native-windows                      |         | from boilerplate                   |
| @react-native-async-storage/async-storage | ~1.15.5 | for persistence                    |
| @react-native-community/hooks             | ~2.6.0  | To handle statefulness             |
| use-interval                              | ~1.3.0  | Hook for time intervals            |
| airbnb-prop-types                         | ~2.16.0 | Programming Addon                  |
| react-native-error-boundary               | ~1.1.10 | Display errors in app and terminal |
| date-fns                                  | ~2.23.0 | Date library                       |
| react-native-svg                          | ~12.1.1 | SVG library                        |
| react-native-countdown-circle-timer       | ~2.5.3  | Library to animate countdowns      |
| chroma-js                                 | ~2.1.2  | calculate contrast ratios          |

---

Example of how to add Dev Dependency, `yarn add -D --tilde eslint`

—

| Dev Dependency                        | Version | Why we are Adding               |
| ------------------------------------- | ------- | ------------------------------- |
| @babel/core                           |         | from boilerplate                |
| @babel/runtime                        |         | from boilerplate                |
| @react-native-community/eslint-config |         | from boilerplate                |
| babel-jest                            |         | from boilerplate                |
| eslint                                |         | from boilerplate                |
| jest                                  |         | from boilerplate                |
| metro-react-native-babel-preset       |         | from boilerplate                |
| react-test-renderer                   |         | from boilerplate                |
| eslint-plugin-react-hooks             | ~4.2.0  | Enforce proper calling of Hooks |
| commander                             | ~8.1.0  | CLI argument parsing            |

## VSCode

`Ctrl-Shift-P`

- _Auto Attach_ (to attach the debugger to run in vscode)

If things are correct you will see, "[Info] About to get:"

> ` http://localhost:8081/index.bundle?platform=windows`

## High-Contrast Mode

Browsers, React, React-Native, etc. all support a dark-mode and light-mode for color themes. They currently only browsers have begun to support a high-contrast mode. Windows has supported high-contrast and other accessibility features for decades.

A React-native-windows app, it would seem, must be required to support high-contrast.

### Development

The hot-key to turn on high-contrast is:

```bash
Alt-LeftShift-PrtSc
```

The transition is not instantaneous.

### Testing

Testing cross-cutting aspects is always problematic and testing high-contrast mode is difficult.

1. Test the test
   Since we have to mock high-contrast mode, as with all mocks, the mock will need its own test.
   1. Do context menus switch to high-contrast
   2. Is the high-contrast mechanism global within the context of the test
2. Did styles change to high-contrast styles by name (this test labels, not pixels)
3. Prop Test (ala ScalaCheck) a random patch. If the sample has a high enough deviation between pixels it pas

## Troubleshooting

```bash
> npx react-native doctor
> nenvinfo
```
