// import 'package:app/Screens/Main_Screens/Discussion/discussion_screen.dart';
// import 'package:app/Screens/Main_Screens/Projects/projects_screen.dart';
// import 'package:app/Screens/Main_Screens/Resources/resources_list_screens.dart';
// import 'package:app/Screens/Main_Screens/Tasks/tasks_screen.dart';
// import 'package:app/Screens/Main_Screens/Training/training_screen.dart';
// import 'package:app/Screens/Main_Screens/dashboard_screen.dart';
// import 'package:app/widget/Drawer_screen.dart';
// import 'package:app/widget/navbar_widget.dart';
// import 'package:flutter/material.dart';

// class LayoutScreen extends StatefulWidget {
//   const LayoutScreen({super.key});

//   @override
//   State<LayoutScreen> createState() => _LayoutScreenState();
// }

// class _LayoutScreenState extends State<LayoutScreen> {
//   int _selectedIndex = 0;

//   final List<Widget> _screens = const [
//     ProjectsScreen(),
//     ResourcesListScreens(),
//     DashboardScreen(),
//     TasksScreen(),
//     DiscussionScreen(),
//     TrainingScreen(),
//   ];

//   final List<String> _appTitles = [
//     "Projects",
//     "Resources",
//     "Dashboard",
//     "Tasks",
//     "Discussion",
//     "Training",
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_appTitles[_selectedIndex]),
//         actions: const [
//           Icon(Icons.notifications),
//           CircleAvatar(
//             radius: 20,
//             child: Icon(Icons.person_2_sharp),
//           ),
//         ],
//       ),
//       drawer: const DrawerScreen(),
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: NavBarWidget(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//     );
//   }
// }
