import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:studentui/AnnouncementsTab/Announcements.dart';
import 'package:studentui/HomeScreen.dart';
import 'package:studentui/GroupScreen.dart';
import 'package:studentui/SettingsScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PersistentTabController tabController =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Theme.of(context).bottomAppBarColor,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
          ? 0.0
          : kBottomNavigationBarHeight,
    );
  }

  List<Widget> _buildScreens() {
    return [HomeScreen(), AnnouncementScreen(), MyGroup(), SettingsScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.notes_outlined),
          title: ("Classroom"),
          activeColorPrimary: Theme.of(context).focusColor,
          //activeColorSecondary: Theme.of(context).buttonColor,
          inactiveColorPrimary: Theme.of(context).disabledColor,
          onPressed: null),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.school_rounded),
        title: ("My College"),
        activeColorPrimary: Theme.of(context).focusColor,
        inactiveColorPrimary: Theme.of(context).disabledColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.group_rounded),
        title: ("My Group"),
        activeColorPrimary: Theme.of(context).focusColor,
        inactiveColorPrimary: Theme.of(context).disabledColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Theme.of(context).focusColor,
        inactiveColorPrimary: Theme.of(context).disabledColor,
      ),
    ];
  }
}
