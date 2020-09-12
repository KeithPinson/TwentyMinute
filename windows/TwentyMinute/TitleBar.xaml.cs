using Microsoft.ReactNative;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows;
using Windows.ApplicationModel.Core;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;

namespace TwentyMinute
{
  public sealed partial class AppTitleBar : UserControl
  {
    private CoreApplicationViewTitleBar coreApplicationViewTitleBar;

    public AppTitleBar()
    {
      this.InitializeComponent();

      coreApplicationViewTitleBar = CoreApplication.GetCurrentView().TitleBar;
      this.Loaded += TitleBar_Loaded;
      this.Unloaded += TitleBar_Unloaded;

    }

    private void TitleBar_Loaded(object sender, RoutedEventArgs e)
    {
      coreApplicationViewTitleBar = CoreApplication.GetCurrentView().TitleBar;
      coreApplicationViewTitleBar.IsVisibleChanged -= TitleBar_IsVisibleChanged;
      coreApplicationViewTitleBar.IsVisibleChanged += TitleBar_IsVisibleChanged;
      coreApplicationViewTitleBar.LayoutMetricsChanged -= TitleBar_LayoutMetricsChanged;
      coreApplicationViewTitleBar.LayoutMetricsChanged += TitleBar_LayoutMetricsChanged;
    }

    private void TitleBar_Unloaded(object sender, RoutedEventArgs e)
    {
      coreApplicationViewTitleBar.IsVisibleChanged -= TitleBar_IsVisibleChanged;
      coreApplicationViewTitleBar.LayoutMetricsChanged -= TitleBar_LayoutMetricsChanged;
      coreApplicationViewTitleBar = null;
    }

    private void TitleBar_IsVisibleChanged(CoreApplicationViewTitleBar sender, object args)
    {
      if (TitleBarGrid != null)
      {
        //        TitleBarGrid.Visibility = sender.IsVisible ? Visiblity.Visible : Visibility.Collapsed;
        TitleBarGrid.Visibility = 0; // 0 = Visible, 1 = Hidden, 2 = Collapsed
      }
    }

    private void TitleBar_LayoutMetricsChanged(CoreApplicationViewTitleBar sender, object args)
    {
      if (TitleBarGrid != null)
      {
        TitleBarGrid.Height = sender.Height;
      }
    }

    public void SetContent(UIElement content)
    {
      rootGrid.Children.Add(content);
      Grid.SetRow((FrameworkElement)content, 1);

      //      coreApplicationViewTitleBar.ExtendViewIntoTitleBar = true;

      Window.Current.SetTitleBar(TitleBarGrid);
    }

    public void RemoveContent(UIElement content)
    {
      rootGrid.Children.Remove((FrameworkElement)content);

      //      coreApplicationViewTitleBar.ExtendViewIntoTitleBar = true;

      Window.Current.SetTitleBar(null);
    }
  }
}
