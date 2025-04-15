import 'package:flutter/material.dart';

class NavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const NavBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 27, 24, 24),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.car_crash_sharp),
          label: "Resources",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.my_library_books_sharp),
          label: "Projects",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          label: "Tasks",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_outlined),
          label: "Discussion",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.videocam_rounded),
          label: "Training",
        ),
      ],
    );
  }
}
