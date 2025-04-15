
import 'package:flutter/material.dart';

import 'package:app/widget/appbar_widget.dart';
import 'package:app/Screens/Main_Screens/Discussion/discussion_screen.dart';
import 'package:app/Screens/Main_Screens/Projects/projects_screen.dart';
import 'package:app/Screens/Main_Screens/Resources/resources_list_screens.dart';
import 'package:app/Screens/Main_Screens/Tasks/tasks_screen.dart';
import 'package:app/Screens/Main_Screens/Training/training_screen.dart';
import 'package:app/Screens/Main_Screens/dashboard_screen.dart';
import 'package:app/widget/Drawer_screen.dart';

import 'package:app/widget/navbar_widget.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    ResourcesListScreens(),
    ProjectsScreen(),
    TasksScreen(),
    DiscussionScreen(),
    TrainingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(selectedIndex: _selectedIndex),
      drawer: const DrawerScreen(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
