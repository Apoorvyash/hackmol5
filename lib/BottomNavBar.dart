import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'ChatScreen.dart';
import 'HomeScreen.dart';
import 'Profile.dart';
import 'SafeRoutes.dart';
import 'new_contact.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Widget> navBarList = [
    HomePage(),
    AddContactsPage(),
    ChatScreen(),
    // SafeRoutes(),
  ];

  @override
  Widget build(BuildContext context) {
    // height
    double height = MediaQuery.of(context).size.height;
    // width
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      // floatingActionButton: _selectedIndex != 2
      //     ? FloatingActionButton(
      //   heroTag: "btn2",
      //   backgroundColor: Colors.red,
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => AudioPlayer(),
      //       ),
      //     );
      //   },
      //   child: Text('SOS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
      // )
      //     : null, // Render FAB only for the Search tab (index 1)
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Theme.of(context).bottomAppBarTheme.color,
      key: _scaffoldKey,
      // body: _pages[_selectedIndex],
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: navBarList),
      ),
      bottomNavigationBar: Material(
        elevation: 15,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.01),
          decoration: const BoxDecoration(
            // color: Theme.of(context).cardColor.withOpacity(0.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: GNav(
                curve: Curves.easeOutExpo,
                haptic: true,
                tabBorderRadius: 20,
                //gap: 2,
                activeColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Theme.of(context).colorScheme.tertiary,
                // textStyle: Colors.white,
                tabs: [
                  GButton(
                    iconSize: 25,
                    icon: _selectedIndex == 0
                        ? Icons.home_filled
                        : LineAwesomeIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    iconSize: 25,
                    icon: _selectedIndex == 1 ?  Icons.contacts
                        : Icons.contacts_outlined,
                    text: 'Contacts',
                  ),
                  GButton(
                    iconSize: 25,
                    icon: _selectedIndex == 2
                        ? Icons.auto_awesome
                        : Icons.auto_awesome_outlined,
                    text: 'Sakha',
                  ),
                  // GButton(
                  //   iconSize: 25,
                  //   icon: _selectedIndex == 3 ? Icons.map : Icons.map_outlined,
                  //   text: 'Route',
                  // ),
                  // GButton(
                  //   iconSize: 25,
                  //   icon: _selectedIndex == 4
                  //       ? CupertinoIcons.person_solid
                  //       : CupertinoIcons.person,
                  //   text: 'Profile',
                  // ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
