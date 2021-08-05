using Microsoft.ReactNative;
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

namespace twentyminute
{
  sealed partial class App : ReactApplication
  {
    public App()
    {
#if BUNDLE
            JavaScriptBundleFile = "index.windows";
            InstanceSettings.UseWebDebugger = false;
            InstanceSettings.UseFastRefresh = false;
#else
      JavaScriptBundleFile = "index";
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
      var frame = (Frame)Window.Current.Content;
      frame.Navigate(typeof(MainPage), e.Arguments);

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
      // <=KIP - adjust app dimensions

      //
      // KIP=> Added for transparent Titlebar
      //
      var titleBar = ApplicationView.GetForCurrentView().TitleBar;
      var coreTitleBar =
          Windows.ApplicationModel.Core.CoreApplication.GetCurrentView().TitleBar;

      if (titleBar != null && coreTitleBar != null)
      {
        // Early versions of WinUI3 will crash if the titleBar is set
        titleBar.BackgroundColor = Windows.UI.Colors.Transparent;
        titleBar.ButtonBackgroundColor = Windows.UI.Colors.Transparent;
        titleBar.InactiveBackgroundColor = Windows.UI.Colors.Transparent;
        titleBar.ButtonInactiveBackgroundColor = Windows.UI.Colors.Transparent;

        coreTitleBar.ExtendViewIntoTitleBar = true;
      }
      // <=KIP - transparent Titlebar
    }

    /// <summary>
    /// Invoked when the application is activated by some means other than normal launching.
    /// </summary>
    protected override void OnActivated(IActivatedEventArgs e)
    {
      var preActivationContent = Window.Current.Content;
      base.OnActivated(e);
      if (preActivationContent == null && Window.Current != null)
      {
        // Display the initial content
        var frame = (Frame)Window.Current.Content;
        frame.Navigate(typeof(MainPage), null);
      }
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
    // <= KIP - check for min version
  }
}
