![Twenty Minute](BuildResources/icons/20min_logo.png "Twenty Minute")

# Twenty Minute Developer Notes

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

## …



---

## Design Pattern

We are using a design pattern like MVC (Model-View-Controller) or one of its variants. The names are different but the structure is similar and should be self-evident. This code will be found in the `lib/` folder of the project.

- Components (Business Logic)
- Resources (Data Resources)
- Screens (Named Views aka screens, pages, modal dialogs)
- UI (Widgets)

In terms of the quantity of changes to the code the order should be: UI → Screens  → Components → Resources, where UI changes will happen a lot and Resource changes will happen hardly at all after the initial code is working.

## Architecture

The home screen of the app mirrors the outline the architecture,

- Active Task
- Timer
- Tally Marks

Beneath the Active Task is another whole architecture supporting tasks. And, beneath the Tally Marks is an architecture of reporting work done.

### Active Task

An active task is simply an id reference to a task. It listens to the time to determine its status of: 

- Run
- Hold
- Done
- Clear (meaning none or unknown)

### Timer

Timers by default are 20 minutes. Each second triggers a tick event. A timer has a status either:

- Run in progress
- Run paused
- Run canceled
- Run complete
- Run ready (a pre-run state, run is ready but never has been started)

### Tally Marks

Tally marks are a minimal progress indicator. Tally marks listen to the Active Task for when it is done and then queries the task repository to count the tally marks. Since tally marks are tied to the database through a database lookup they have an internal status of:

- Counting
- Counted
- Count failed
- Count ready (this is a pre-count state)

## Task Architecture



## Report Architecture
