import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/tab_c/tab_c_entry.dart';
import 'package:navigator_example/tabs/screens/tab_a_screen.dart';
import 'package:navigator_example/tabs/screens/tab_b_screen.dart';
import 'package:navigator_example/tabs/tabs_navigator.dart';

class TabsScreen extends StatefulWidget {
  final VoidCallback? onSettingsClick;
  final int currentPage;

  const TabsScreen({
    Key? key,
    this.onSettingsClick,
    required this.currentPage,
  }) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          if (widget.onSettingsClick != null)
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () => widget.onSettingsClick!.call(),
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
            ),
          ),
          child: IndexedStack(
            index: widget.currentPage,
            children: [
              TabAScreen(),
              TabBScreen(),
              TabCEntryPoint(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) =>
            ContextedNavigatorProvider.of<TabsChangeEvent>(context)
                ?.addEvent(TabsChangeEvent(index)),
        currentIndex: widget.currentPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tab A',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Tab B',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: 'Tab C',
          ),
        ],
      ),
    );
  }
}
