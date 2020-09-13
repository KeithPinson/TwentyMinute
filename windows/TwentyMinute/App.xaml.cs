using Microsoft.ReactNative;
using Windows.ApplicationModel;
using Windows.ApplicationModel.Activation;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;

// KIP=> Added to adjust app dimensions
using Windows.UI.ViewManagement;
using Windows.Foundation;
// <=KIP

// KIP=> Added for transparent titlebar
using Windows.UI;
using Windows.ApplicationModel.Core;
// <=KIP

// KIP=> Added for CompactOverlay (Always On Top) behavior
using System;
using System.Threading.Tasks;
// <=KIP

namespace TwentyMinute
{
  sealed partial class App : ReactApplication
  {
    private AppTitleBar appTitleBar;
    private UIElement cacheContent;

    public App()
    {
#if BUNDLE
            JavaScriptBundleFile = "index.windows";
            InstanceSettings.UseWebDebugger = false;
            InstanceSettings.UseFastRefresh = false;
#else
      JavaScriptMainModuleName = "index";
      InstanceSettings.UseWebDebugger = true;
      InstanceSettings.UseFastRefresh = true;
#endif

#if DEBUG
      InstanceSettings.UseDeveloperSupport = true;
#else
      InstanceSettings.UseDeveloperSupport = false;
#endif

      Microsoft.ReactNative.Managed.AutolinkedNativeModules.RegisterAutolinkedNativeModulePackages(PackageProviders); // Includes any autolinked modules

      PackageProviders.Add(new Microsoft.ReactNative.Managed.ReactPackageProvider());
      PackageProviders.Add(new ReactPackageProvider());

      InitializeComponent();
    }

    /// <summary>
    /// Invoked when the application is launched normally by the end user.  Other entry points
    /// will be used such as when the application is launched to open a specific file.
    /// </summary>
    /// <param name="e">Details about the launch request and process.</param>
    protected override void OnLaunched(LaunchActivatedEventArgs e)
    {
      base.OnLaunched(e);
      var frame = Window.Current.Content as Frame;
      frame.Navigate(typeof(MainPage), e.Arguments);

      Window.Current.Activate();

      //
      // KIP=> Added to adjust app dimensions
      //
      if (IsOSTooOld(15063))
      {
        return;
      }

      var view = ApplicationView.GetForCurrentView();

      if (view != null)
      {
        // The system sets the window size directly so the preferred size
        // is ignored, instead we will use TryResizeView()
        //        ApplicationView.PreferredLaunchViewSize = new Windows.Foundation.Size(120, 120);

        // Hard coding the size for now...
        var desiredSize = new Windows.Foundation.Size(200, 220);
        var minSize = new Windows.Foundation.Size(100, 100);

        view.SetPreferredMinSize(minSize);

        view.TryResizeView(desiredSize);
      }
      // <=KIP

      //
      // KIP=> Added for transparent Titlebar
      //
      var titleBar = ApplicationView.GetForCurrentView().TitleBar;
      var coreTitleBar =
          Windows.ApplicationModel.Core.CoreApplication.GetCurrentView().TitleBar;

      if (titleBar != null && coreTitleBar != null)
      {
        titleBar.BackgroundColor = Windows.UI.Colors.Transparent;
        titleBar.ButtonBackgroundColor = Windows.UI.Colors.Transparent;
        titleBar.InactiveBackgroundColor = Windows.UI.Colors.Transparent;
        titleBar.ButtonInactiveBackgroundColor = Windows.UI.Colors.Transparent;
        coreTitleBar.ExtendViewIntoTitleBar = true;
      }
      // <=KIP

      //
      // KIP=> Added for Titlebar Buttons
      //
      if (view != null && titleBar != null && coreTitleBar != null)
      {
        if (appTitleBar == null)
        {
          appTitleBar = new AppTitleBar();

          //          cacheContent = this.Content;
          //          this.Content = appTitleBar;
          //          appTitleBar.SetContent(cacheContent);
        }
      }
      // <=KIP        
    }


    // KIP=> Check for minimum required Windows 10 version
    /// <summary>
    /// React Native Windows requires build 10586 (version 1511) or greater. 
    /// Defensively check if a version is older than that.
    /// </summary>
    /// <param name="build">Defaults to 10586. ApplicationView min is 15063.</param>
    private static bool IsOSTooOld(ulong build = 10586)
    {
      string sv = Windows.System.Profile.AnalyticsInfo.VersionInfo.DeviceFamilyVersion;
      ulong v = ulong.Parse(sv);
      ulong osbuild = (v & 0x00000000FFFF0000L) >> 16;

      return (osbuild < build);
    }

    // KIP=> Added for CompactOverlay (Always On Top) behavior
    /// <summary>
    /// Use the PiP support to substitute for Always On Top behavior.
    /// </summary>
    /// <param name="isOnTop">Defaults to true. Use false to turn the on-top behavior off.</param>
    private static async Task KeepAlwaysOnTop(bool isOnTop = true)
    {
      if (IsOSTooOld(15063))
      {
        return;
      }

      var view = ApplicationView.GetForCurrentView();

      if (view != null)
      {
        if (isOnTop)
        {
          // Need to handle full screen and always on top, for now make sure we don't start full screen
          view.ExitFullScreenMode();

          // KIP=> This will be moved to private async method
          var customOptions = ViewModePreferences.CreateDefault(ApplicationViewMode.CompactOverlay);
          customOptions.CustomSize = new Windows.Foundation.Size(200, 220);
          customOptions.ViewSizePreference = ViewSizePreference.Custom;

          // Keep always on top...
          await view.TryEnterViewModeAsync(ApplicationViewMode.CompactOverlay, customOptions);
        }
        else
        {
          // Go back to a regular layering window...
          await view.TryEnterViewModeAsync(ApplicationViewMode.Default);
        }
      }
    }
    // <=KIP
  }
}
