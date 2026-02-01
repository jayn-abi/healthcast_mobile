import 'package:flutter/material.dart';
import '../constants.dart';

class HealthCastBottomNav extends StatelessWidget {
  final int currentIndex;

  const HealthCastBottomNav({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    const routes = [
      '/weather',
      '/surveillance',
      '/alerts',
      '/diseases',
      '/profile',
    ];

    final current = ModalRoute.of(context)?.settings.name;
    if (current != routes[index]) {
      Navigator.pushReplacementNamed(context, routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: LIGHT_PRIMARY.withOpacity(0.55),
              width: 1,
            ),
          ),
        ),
        child: SizedBox(
          height: 78, 
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (i) => _onTap(context, i),
            type: BottomNavigationBarType.fixed,

            selectedItemColor: SECONDARY,
            unselectedItemColor: DARK_PRIMARY.withOpacity(0.55),
            selectedFontSize: 11,
            unselectedFontSize: 11,

            backgroundColor: Colors.white,
            elevation: 0,

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud_outlined),
                label: "Weather",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart_rounded),
                label: "Surveillance",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none_rounded),
                label: "Alerts",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bug_report_outlined),
                label: "Diseases",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
