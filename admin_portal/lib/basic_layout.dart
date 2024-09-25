import 'package:admin_portal/screens/main/dashboard_screen.dart';
import 'package:admin_portal/screens/main/departments_list.dart';
import 'package:admin_portal/screens/main/discussion.dart';
import 'package:admin_portal/screens/projects/project_details_screen.dart';
import 'package:admin_portal/screens/main/resource_screen.dart';
import 'package:admin_portal/screens/main/tasks_screen.dart';
import 'package:admin_portal/screens/main/user_details_screen.dart';
import 'package:admin_portal/screens/projects/project_list_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';

class BasicLayout extends StatefulWidget {
  const BasicLayout({super.key});

  @override
  State<BasicLayout> createState() => _BasicLayoutState();
}

class _BasicLayoutState extends State<BasicLayout> {
  int _selectedIndex = 0;
  int _partsIndex = 0;
  Color active = Colors.blue;
  Color not_select = const Color.fromARGB(255, 12, 12, 12);

  List<Widget> _screens = [
    const DashboardScreen(),
    const DepartmentsList(),
    const ProjectListScreen(),
    const UserDetailsScreen(),
    const ResourceScreen(),
    const TasksScreen(),
    const Discussion(),
    const ProjectDetailsScreen(),
  ];
  List<Widget> _parts = [
    ProjectDetailsScreen(),
  ];

  void _onScreenTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var b = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 12, 12, 12),
              ),
              height: h * 0.11,
              child: Row(
                children: [
                  SizedBox(
                    width: b * 0.01,
                  ),
                  Image.asset(
                    "assets/images/ell.png",
                    height: h * 0.26,
                  ),
                  SizedBox(
                    width: b * 0.015,
                  ),
                  Image.asset("assets/images/sangam.png"),
                  SizedBox(
                    width: b * 0.54,
                  ),
                  Container(
                    height: h * 0.05,
                    width: b * 0.17,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: "    search here"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: b * 0.01,
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: h * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // left side part
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                  width: b * 0.15,
                  height: h * 0.86,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => _onScreenTap(0),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 2,
                            left: 6,
                            right: 6,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedIndex == 0 ? active : not_select,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 40,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.dashboard,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Dashboard",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _onScreenTap(1);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            left: 6,
                            right: 6,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                              color: _selectedIndex == 1 ? active : not_select,
                            ),
                            height: 40,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.copy,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Departments",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _onScreenTap(2);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            left: 6,
                            right: 6,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                              color: _selectedIndex == 2 ? active : not_select,
                            ),
                            height: 40,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Projects",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _onScreenTap(3);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            left: 6,
                            right: 6,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                              color: _selectedIndex == 3 ? active : not_select,
                            ),
                            height: 40,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.fire_truck,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Resources",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _onScreenTap(4);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            left: 6,
                            right: 6,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                              color: _selectedIndex == 4 ? active : not_select,
                            ),
                            height: 40,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.task,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Users",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _onScreenTap(5),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            left: 6,
                            right: 6,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                              color: _selectedIndex == 5 ? active : not_select,
                            ),
                            height: 40,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.task,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Tasks",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _onScreenTap(6);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            left: 6,
                            right: 6,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                              color: _selectedIndex == 6 ? active : not_select,
                            ),
                            height: 40,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.task,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Discussion",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _onScreenTap(7);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            left: 6,
                            right: 6,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                              color: _selectedIndex == 7 ? active : not_select,
                            ),
                            height: 40,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.task,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Projects Details",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            left: 6,
                            right: 6,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 40,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Log out",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // RIGHT SIDE OF PORTAL
              _screens[_selectedIndex],
            ],
          ),
        ],
      ),
    );
  }
}
