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
  Page get _splashPage => CustomMaterialPage(
        key: ValueKey('splash'),
        child: SplashScreen(),
      );

  Page get _loginScreen => CustomMaterialPage(
        key: ValueKey('logn'),
        child: LoginScreen(),
      );

  Page get _settingScreen => CustomMaterialPage(
        key: ValueKey('setting'),
        child: SettingsEntryPoint(),
      );

  Page get _tabsScreen => CustomMaterialPage(
        key: ValueKey('tabs'),
        child: TabsEntryPoint(
          onSettingsClick: () => navigator.addEvent(MainSettingsEvent()),
        ),
      );

  @override
  Map<String, DeepLinkPageBuilder> get deepLinks => {
        'login': (_) async => _loginScreen,
        'tabs': (_) async => _tabsScreen,
        'settings': (_) async => _settingScreen,
      };

  @override
  List<Page> mapEventToPages(MainEvent event, List<Page> pages) {
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
  List<Page> get initialPages => [_splashPage];
}
