import 'package:flutter/material.dart';
import 'package:pocket_psychologist/constants/app_colors/app_colors.dart';
import 'package:pocket_psychologist/features/chat/page/chat_page.dart';
import 'package:pocket_psychologist/features/home/page/home_page.dart';
import 'package:pocket_psychologist/features/profile/page/profile_page.dart';
import 'package:pocket_psychologist/features/vip/page/vip_page.dart';

import '../features/surveys_and_exercises/presentation/page/surveys_and_exercises_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
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
    final _color = AppColors.mainColor;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        // backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Домашняя",
            backgroundColor: _color,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: "Упражнения",
            backgroundColor: _color,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: "Чат",
            backgroundColor: _color,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: "VIP",
            backgroundColor: _color,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Профиль",
            backgroundColor: _color,
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
