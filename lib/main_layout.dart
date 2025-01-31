import 'package:aaaaa/widget/appointment_page.dart';
import 'package:aaaaa/widget/home_page.dart';
import 'package:aaaaa/widget/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class mLayout extends StatefulWidget {
  const mLayout({super.key});

  @override
  State<mLayout> createState() => _mLayoutState();
}

class _mLayoutState extends State<mLayout> {
  int cPage = 0; //current
  final PageController _pages = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pages,
        onPageChanged: ((value) {
          setState(() {
            cPage = value;
          });
        }),
        children: const <Widget>[
          HomePage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: cPage,
        onTap: (page) {
          setState(() {
            cPage = page;
            _pages.animateToPage(page,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut);
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house), label: 'Home'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: 'Profile'),
        ],
      ),
    );
  }
}
