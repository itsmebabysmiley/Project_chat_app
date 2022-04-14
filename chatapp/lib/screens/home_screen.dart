import 'package:chatapp/pages/contact_page.dart';
import 'package:chatapp/pages/messages_page.dart';
import 'package:chatapp/screens/profile_screen.dart';
import 'package:chatapp/theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  final pages = const [
    ContactPage(),
    MessagesPage(),
    ProfileScreen()
  ];

  final pageTitles = const [
    "Contact",
    "Messages",
    "Profile" 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: Text(pageTitles[_selectedIndex]),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.secondary,
        onTap: _onItemTapped,
      ),
    );
  }
}