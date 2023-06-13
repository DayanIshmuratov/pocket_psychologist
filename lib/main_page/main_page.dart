import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/greeting/greeting.dart';
import 'package:pocket_psychologist/constants/app_colors/app_colors.dart';
import 'package:pocket_psychologist/features/home/page/home_page.dart';
import 'package:pocket_psychologist/features/profile/page/profile_page.dart';
import 'package:pocket_psychologist/features/vip/page/vip_page.dart';

import '../features/chat/presentation/page/chat_page.dart';
import '../features/surveys_and_exercises/presentation/page/surveys_and_exercises_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() {

    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  int _selectedIndex = 1;
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SurveysAndExercisesPage(),
    ChatPage(),
    VipPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        // backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Домашняя",
            backgroundColor: color,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: "Опросы",
            backgroundColor: color,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: "Чат",
            backgroundColor: color,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: "VIP",
            backgroundColor: color,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Профиль",
            backgroundColor: color,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }
}
