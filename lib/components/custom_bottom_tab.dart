import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/screens/bookmark/bookmark_screen.dart';
import 'package:testapp/screens/discover/discover_screen.dart';
import 'package:testapp/screens/home/home_screen.dart';
import 'package:testapp/screens/profile/profile_screen.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key, this.initRoute}) : super(key: key);
  static String routeName = "/";
  final int? initRoute;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late int _selectedIndex = widget.initRoute ?? 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    DiscoverScreen(),
    BookmarkScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.queue),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
        iconSize: 25,
        backgroundColor: Colors.white,
      ),
    );
  }
}
