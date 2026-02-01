
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
return Container(
decoration: const BoxDecoration(
  gradient:  LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0, 0.6, 1.0],
  colors: [
    Color(0xFFDDECF4),
    Color(0xFFFFFFFF),
    Color(0xFFC7DDEA),

  ],
),

),




  child: Scaffold(
    backgroundColor: Colors.transparent,
    appBar: const HealthCastTopBar(
      title: "Hello, Cham!",
      subtitle: "Quezon City, Philippines",
    ),
    body: LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final scale = _scaleForWidth(w);
        final padX = (w * 0.05).clamp(16.0, 22.0);
        final bottomInset = MediaQuery.of(context).padding.bottom;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            padX,
            14 * scale,
            padX,
            18 * scale + kBottomNavigationBarHeight + bottomInset + 8, 
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  AnimatedWeatherCard(scale: scale),

                 SizedBox(height: (36 * scale).clamp(30.0, 52.0)),


                    LayoutBuilder(
                      builder: (context, constraints) {
                        final w = constraints.maxWidth * 0.92;

                        return Center(
                          child: SizedBox(
                            width: w,
                            child: Text(
                              "Disease Risk Levels",
                              style: TextStyle(
                                color: PRIMARY,
                                fontSize: (12 * scale).clamp(14.0, 16),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),



                SizedBox(height: (16 * scale).clamp(14.0, 24.0)),



                  const RiskTile(
                    accent: Color(0xFFE7000B),
                    title: "Dengue",
                    subtitle: "342 cases reported this week",
                    badgeText: "High",
                    badgeGradient: LinearGradient(
                      colors: [Color(0xFFE7000B), Color(0xFFFDA4AF)],
                    ),
                  ),

                  SizedBox(height: (16 * scale).clamp(14.0, 24.0)),

                  const RiskTile(
                    accent: Color(0xFFE17100),
                    title: "Zika",
                    subtitle: "89 cases reported this week",
                    badgeText: "Medium",
                    badgeGradient: LinearGradient(
                      colors: [Color(0xFFE17100), Color(0xFFFFD4A9)],
                    ),
                  ),

                  SizedBox(height: (16 * scale).clamp(14.0, 24.0)),

                  const RiskTile(
                    accent: Color(0xFF009966),
                    title: "Japanese Encephalitis",
                    subtitle: "45 cases reported this week",
                    badgeText: "Low",
                    badgeGradient: LinearGradient(
                      colors: [Color(0xFF009966), Color(0xFF00FFAA)],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
    bottomNavigationBar: const HealthCastBottomNav(currentIndex: 0),
  ),
);

  }
}


  double _scaleForWidth(double width) {
    if (width >= 900) return 1.12;
    if (width >= 700) return 1.08;
    if (width >= 500) return 1.04;
    return 1.0;
  }



class AnimatedWeatherCard extends StatefulWidget {
  final double scale;
  const AnimatedWeatherCard({super.key, required this.scale});

  @override
  State<AnimatedWeatherCard> createState() => _AnimatedWeatherCardState();
}

class _AnimatedWeatherCardState extends State<AnimatedWeatherCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.scale;

return FadeTransition(
  opacity: _fade,
  child: SlideTransition(
    position: _slide,
    child: LayoutBuilder(
      builder: (context, constraints) {
        final cardW = constraints.maxWidth * 0.92;

        return Center(
          child: SizedBox(
            width: cardW,
            child: Container(
              padding: EdgeInsets.fromLTRB(16 * s, 14 * s, 16 * s, 14 * s),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    SECONDARY.withOpacity(0.95),
                    DARK_PRIMARY.withOpacity(0.95),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Quezon City, Philippines",
                    style: TextStyle(
                      color: TEXT_COLOR_WHITE.withOpacity(0.80),
                      fontSize: (12.0 * s).clamp(12.0, 14.0),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: (8 * s).clamp(6.0, 10.0)),
                  Text(
                    "28°C",
                    style: TextStyle(
                      color: TEXT_COLOR_WHITE,
                      fontSize: (30 * s).clamp(26.0, 34.0),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Partly Cloudy",
                    style: TextStyle(
                      color: TEXT_COLOR_WHITE.withOpacity(0.85),
                      fontSize: (13 * s).clamp(12.0, 14.5),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: (12 * s).clamp(10.0, 14.0)),
                  Divider(color: TEXT_COLOR_WHITE.withOpacity(0.18), height: 1),
                  SizedBox(height: (10 * s).clamp(8.0, 12.0)),
                  Row(
                    children: [
                      _MiniStat(
                        icon: Icons.water_drop_outlined,
                        label: "Humidity",
                        value: "75%",
                        scale: s,
                      ),
                      _MiniStat(
                        icon: Icons.air_rounded,
                        label: "Wind",
                        value: "12 km/h",
                        scale: s,
                      ),
                      _MiniStat(
                        icon: Icons.cloudy_snowing,
                        label: "Rainfall",
                        value: "45 mm",
                        scale: s,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  ),
);


  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double scale;

  const _MiniStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: TEXT_COLOR_WHITE.withOpacity(0.9), size: (18 * scale).clamp(16.0, 20.0)),
          SizedBox(height: (6 * scale).clamp(5.0, 8.0)),
          Text(
            label,
            style: TextStyle(
              color: TEXT_COLOR_WHITE.withOpacity(0.75),
              fontSize: (11.0 * scale).clamp(10.5, 12.0),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              color: TEXT_COLOR_WHITE,
              fontSize: (12.0 * scale).clamp(11.5, 13.0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class RiskTile extends StatelessWidget {
  final Color accent;
  final String title;
  final String subtitle;
  final String badgeText;
  final LinearGradient badgeGradient;

  const RiskTile({
    super.key,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.badgeGradient,
  });

  @override
  @override
Widget build(BuildContext context) {
  const double radius = 12;

  return LayoutBuilder(
    builder: (context, constraints) {
      final tileW = constraints.maxWidth * 0.92; 

      return Center(
        child: SizedBox(
          width: tileW,
          child: Container(
            decoration: BoxDecoration(
              color: TEXT_COLOR_WHITE,
              borderRadius: BorderRadius.circular(radius),
              border: Border(
                left: BorderSide(
                  color: accent,
                  width: 6,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: PRIMARY,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: badgeGradient,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      badgeText,
                      style: const TextStyle(
                        color: TEXT_COLOR_WHITE,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

}






