![Twenty Minute](BuildResources/icons/20min_logo.png "Twenty Minute")

# Twenty Minute Developer Notes

(This is the outline from the ReactNative version. It may not need to be so extensive.)

[TOC]

## Step 0: Installation 

 <u>Install Flutter and Dart</u>

- https://docs.flutter.dev/get-started/install

<u>Install Visual Studio (for Windows Desktop apps)</u>

- https://visualstudio.microsoft.com/downloads/ 
- Download "Visual Studio 2022 with C++" Community edition.
- Run *Visual Studio Installer*

<u>Check the Installation</u>

```bash
> flutter doctor -v
```

<u>Confirm Environment Variables</u>

Visual Studio Installer may not have updated the environment variables, they should match and be set to something like:

- `VCToolsVersion=14.29.30037`
- `VCToolsInstallDir=%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\%VCToolsVersion%`

## Step 1: Building the Apps

To build the release version of the Windows app:

```bash
> flutter build windows  :: This builds exe file in ./build/windows/runner/Release/ directory
```

Alternatively:

```bash
> flutter create .
> flutter run -d <"macos", "linux", or "windows"> 
```

## Step 2: Install the Dependencies

## Step 3: Check Windows 10 Version

## Step 4: Windows -- Update Icons

## Step 5: Windows -- App Window Size

## Step 6: Windows -- Transparency

## Step 7: Windows -- Always On Top Button

## High-Contrast Mode

## Tally Marks

<u>In Unicode:</u>

1D377 &#x1D377; Tally Mark One
1D378 &#x1D378; Tally Mark Five

<u>With custom font use</u>

ascii character:     1 2 3 4 5 6 7 8 9 a b c d e f  A B C D E
                             |              |              |              |              |
to get tally mark:  |1 2 3 4 5|1 2 3 4 5|1 2 3 4 5|1 2 3 4 5|

## To Rebuild Android

```bash
> flutter clean
> flutter build apk
> flutter run
```

## Problems with Upgrade to Flutter 3.0.0 or greater

Older packages of `bitsdojo_window` and `adaptive_theme` will
throw errors and warnings after upgrading to Flutter version 3.

To roll-back the version:

```bash
> flutter downgrade 2.10.5
```

To stick with Flutter 3

 - Live with `adaptive_theme` throwing warnings, it will eventually be fixed
 - Patch `bitsdojo_window` (it may be fixed by the time you read this)

<u>Adaptive_theme Warning</u>:

```
adaptive_theme.dart: warning ... Operand of null-aware operation ...
```

Ignore these until a official fix is made.

<u>To patch 'Bitsdojo_window' before the fix is released</u>:

Before the patch you will get an error revealing a namespace conflict:

```
'Size' is imported from both 'dart:ffi' and 'dart:ui'
```

Add the `hide Size` to the `import 'dart.ffi'` directives in the windows 
and linux directories of the `bitsdojo_window` package, which can be found
in the `.pub-cache` of the current version of Flutter on your system.

The patch will simply look like this:

```dart
import 'dart:ffi' hide Size;
```

