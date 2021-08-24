import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:navigator_example/tabs/tabs_navigator.dart';

class TabsEntryPoint extends StatelessWidget {
  final VoidCallback? onSettingsClick;

  const TabsEntryPoint({
    Key? key,
    this.onSettingsClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContextedNavigatorProvider<TabsChangeEvent>(
      createDelegate: (context) => TabsNavigator(),
      builder: (context) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () =>
                ContextedNavigatorProvider.of<TabsChangeEvent>(context)?.pop(),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          actions: [
            if (onSettingsClick != null)
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () => onSettingsClick!.call(),
                  child: Hero(
                    tag: 'settings',
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
              width: 1,
              color: Colors.black54,
            )),
            child: ContextedNavigationContainer<TabsChangeEvent>(),
          ),
        ),
        bottomNavigationBar:
            ContextedNavigationListenableBuilder<TabsChangeEvent>(
          builder: (_, pages) {
            return BottomNavigationBar(
              onTap: (index) =>
                  ContextedNavigatorProvider.of<TabsChangeEvent>(context)
                      ?.addEvent(TabsChangeEvent(index)),
              currentIndex: pages.lastOrNull?.key is ValueKey<int>
                  ? (pages.lastOrNull?.key as ValueKey<int>).value
                  : 0,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Tab A',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Tab B',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Tab C',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
