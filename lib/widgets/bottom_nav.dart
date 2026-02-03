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
    const items = <_NavItem>[
      _NavItem(Icons.cloud_outlined, "Weather"),
      _NavItem(Icons.show_chart_rounded, "Surveillance"),
      _NavItem(Icons.notifications_none_rounded, "Alerts"),
      _NavItem(Icons.bug_report_outlined, "Diseases"),
      _NavItem(Icons.person_outline_rounded, "Profile"),
    ];

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: LIGHT_PRIMARY.withOpacity(0.45),
              width: 1,
            ),
          ),
        ),
        child: SizedBox(
          height: 78,
          child: Row(
            children: List.generate(items.length, (i) {
              final isActive = i == currentIndex;
              final item = items[i];

              return Expanded(
                child: InkWell(
                  onTap: () => _onTap(context, i),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                   
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOut,
                          
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? LIGHT_PRIMARY.withOpacity(0.30) 
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            item.icon,
                            size: 24,
                            color: isActive
                                ? DARK_PRIMARY
                                : DARK_PRIMARY.withOpacity(0.55),
                          ),
                        ),

                        const SizedBox(height: 3),

                       
                        SizedBox(
                          height: 6,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 160),
                            opacity: isActive ? 1 : 0,
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: DARK_PRIMARY,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 3),

                       
                        Text(
                          item.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                                isActive ? FontWeight.w700 : FontWeight.w500,
                            color: isActive
                                ? DARK_PRIMARY
                                : DARK_PRIMARY.withOpacity(0.55),
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}
