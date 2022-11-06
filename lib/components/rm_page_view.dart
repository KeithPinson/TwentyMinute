/// A PageView for routes
///
///
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///


// final routes = RouteMap(
//  routes: {
//   '/' : (routeData) => CupertinoTabPage(
//    child: App(screen: HomeScreen()),
//    paths: const ['/profile','/settings'],
//   ),
//   '/profile' : (_) => const MaterialPage(child: ProfilePage()),
//   '/settings' : (_) => const MaterialPage(child: SettingsPage()),
//  },
// );
//
// final tabState = CupertinoTabPage.of(context);
//
// return CupertinoTabScaffold(
//  controller: tabState.controller,
//  tabBuilder: tabState.tabBuilder,
//  tabBar: CupertinoTabBar(
//   items: const [
//    BottomNavigationBarItem(
//     label: 'Feed',
//     icon: Icon(CupertinoIcons.list_bullet),
//    ),
//    BottomNavigationBarItem(
//     label: 'Settings',
//     icon: Icon(CupertinoIcons.search),
//    ),
//   ],
//  ),
// );




// '/' : (routeData) => PageView(
//   controller:
//   children:
//   onPageChanged:
// ),


/*
package:flutter/src/widgets/page_view.dart (new)
PageView PageView({
  Key? key,
  Axis scrollDirection = Axis.horizontal,   bool reverse = false,   PageController? controller,   ScrollPhysics? physics,   bool pageSnapping = true,   void Function(int)? onPageChanged,   List<Widget> children = const <Widget>[],   DragStartBehavior dragStartBehavior = DragStartBehavior.start,   bool allowImplicitScrolling = false,   String? restorationId,   Clip clipBehavior = Clip.hardEdge,   ScrollBehavior? scrollBehavior,   bool padEnds = true, })  Containing class: PageView
 */


  /// Creates a scrollable list that works page by page from an explicit [List]
  /// of widgets.
  ///
  /// This constructor is appropriate for page views with a small number of
  /// children because constructing the [List] requires doing work for every
  /// child that could possibly be displayed in the page view, instead of just
  /// those children that are actually visible.
  ///
  /// Like other widgets in the framework, this widget expects that
  /// the [children] list will not be mutated after it has been passed in here.
  /// See the documentation at [SliverChildListDelegate.children] for more details.
  ///
  /// {@template flutter.widgets.PageView.allowImplicitScrolling}
  /// The [allowImplicitScrolling] parameter must not be null. If true, the
  /// [PageView] will participate in accessibility scrolling more like a
  /// [ListView], where implicit scroll actions will move to the next page
  /// rather than into the contents of the [PageView].
  /// {@endtemplate}
