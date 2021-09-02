import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/main/screens/login_screen.dart';
import 'package:navigator_example/main/screens/splash_screen.dart';
import 'package:navigator_example/settings/settings_entry.dart';
import 'package:navigator_example/tabs/tabs_entry.dart';

abstract class MainEvent extends NavigationEvent {}

class MainSplashEvent extends MainEvent {}

class MainLoginEvent extends MainEvent {}

class MainTabsEvent extends MainEvent {}

class MainSettingsEvent extends MainEvent {}

class MainNavigator extends ContextedNavigatorDelegate<MainEvent> {
  CustomMaterialPage get _splashPage => CustomMaterialPage(
        key: ValueKey('splash'),
        child: SplashScreen(),
      );

  CustomMaterialPage get _loginScreen => CustomMaterialPage(
        key: ValueKey('logn'),
        child: LoginScreen(),
      );

  CustomMaterialPage get _settingScreen => CustomMaterialPage(
        key: ValueKey('setting'),
        child: SettingsEntryPoint(),
      );

  CustomMaterialPage get _tabsScreen => CustomMaterialPage(
        key: ValueKey('tabs'),
        child: TabsEntryPoint(
          onSettingsClick: () => navigator.addEvent(MainSettingsEvent()),
        ),
      );

  @override
  Map<String, DeepLinkPageBuilder> get deepLinks => {
        'login': (_) => _loginScreen,
        'tabs': (_) => _tabsScreen,
        'settings': (_) => _settingScreen,
      };

  @override
  List<CustomMaterialPage> mapEventToPages(MainEvent event, List<CustomMaterialPage> pages) {
    if (event is MainSplashEvent) {
      pages.add(_splashPage);
    } else if (event is MainLoginEvent) {
      pages.add(_loginScreen);
    } else if (event is MainTabsEvent) {
      pages.add(_tabsScreen);
    } else if (event is MainSettingsEvent) {
      pages.add(_settingScreen);
    }
    return pages;
  }

  @override
  List<CustomMaterialPage> get initialPages => [_splashPage];
}
