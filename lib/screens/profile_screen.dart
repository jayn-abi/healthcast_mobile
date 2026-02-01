
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
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
      extendBody: true,
      appBar: const HealthCastTopBar(
        title: "Profile",
        subtitle: "Manage your account information",
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
              20 * scale + kBottomNavigationBarHeight + bottomInset + 8, 
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Column(
                  children: [
                    _ProfileHeaderCard(scale: scale),
                    SizedBox(height: (14 * scale).clamp(12.0, 18.0)),
                    _PersonalInfoCard(scale: scale),
                    SizedBox(height: (36 * scale).clamp(32.0, 48.0)),
                    _LogoutButton(
                      scale: scale,
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const HealthCastBottomNav(currentIndex: 4),
    ),
  );
}
}

class _ProfileHeaderCard extends StatelessWidget {
  final double scale;
  const _ProfileHeaderCard({required this.scale});

  @override
  @override
Widget build(BuildContext context) {
  final s = scale;

  return LayoutBuilder(
    builder: (context, constraints) {
      final cardW = constraints.maxWidth * 0.92; 

      return Center(
        child: SizedBox(
          width: cardW,
          child: Container(
            padding: EdgeInsets.fromLTRB(
              18 * s,
              32 * s,
              18 * s,
              30 * s,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  SECONDARY.withOpacity(0.78),
                  DARK_PRIMARY.withOpacity(0.92),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _AvatarCircle(scale: s + 0.05),
                    SizedBox(width: (16 * s).clamp(14.0, 20.0)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cham Maaya",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: TEXT_COLOR_WHITE,
                              fontSize: (17 * s).clamp(15.5, 20.0),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Member since January 2026",
                            style: TextStyle(
                              color: TEXT_COLOR_WHITE.withOpacity(0.75),
                              fontSize: (12.5 * s).clamp(12.0, 14.0),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: (18 * s).clamp(16.0, 22.0)),
                SizedBox(
                  width: double.infinity,
                  height: (44 * s).clamp(40.0, 48.0),
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit_outlined,
                      size: (17 * s).clamp(16.0, 19.0),
                      color: TEXT_COLOR_WHITE.withOpacity(0.95),
                    ),
                    label: Text(
                      "Edit Profile",
                      style: TextStyle(
                        color: TEXT_COLOR_WHITE.withOpacity(0.95),
                        fontSize: (13.5 * s).clamp(12.5, 14.5),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: TEXT_COLOR_WHITE.withOpacity(0.30),
                        width: 1.2,
                      ),
                      backgroundColor: TEXT_COLOR_WHITE.withOpacity(0.12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

}



class _AvatarCircle extends StatelessWidget {
  final double scale;
  const _AvatarCircle({required this.scale});

  @override
  Widget build(BuildContext context) {
    final s = scale;
    final size = (54 * s).clamp(48.0, 62.0);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: TEXT_COLOR_WHITE.withOpacity(0.18),
        border: Border.all(
          color: TEXT_COLOR_WHITE.withOpacity(0.30),
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        "MM",
        style: TextStyle(
          color: TEXT_COLOR_WHITE,
          fontSize: (16 * s).clamp(14.0, 18.0),
          fontWeight: FontWeight.w800,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _EditProfileButton extends StatelessWidget {
  final double scale;
  const _EditProfileButton({required this.scale});

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return SizedBox(
      width: double.infinity,
      height: (36 * s).clamp(34.0, 42.0),
      child: OutlinedButton.icon(
        onPressed: () {
          // TODO: navigate to edit profile screen 
        },
        icon: Icon(
          Icons.edit_outlined,
          size: (16 * s).clamp(15.0, 18.0),
          color: TEXT_COLOR_WHITE.withOpacity(0.92),
        ),
        label: Text(
          "Edit Profile",
          style: TextStyle(
            color: TEXT_COLOR_WHITE.withOpacity(0.92),
            fontSize: (12.5 * s).clamp(12.0, 14.0),
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: TEXT_COLOR_WHITE.withOpacity(0.28), width: 1),
          backgroundColor: TEXT_COLOR_WHITE.withOpacity(0.10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class _PersonalInfoCard extends StatelessWidget {
  final double scale;
  const _PersonalInfoCard({required this.scale});

  @override
@override
Widget build(BuildContext context) {
  final s = scale;

  return LayoutBuilder(
    builder: (context, constraints) {
      final cardW = constraints.maxWidth * 0.92; 

      return Center(
        child: SizedBox(
          width: cardW,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16 * s, 14 * s, 16 * s, 14 * s),
            decoration: BoxDecoration(
              color: TEXT_COLOR_WHITE,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Personal Information",
                  style: TextStyle(
                    color: PRIMARY,
                    fontSize: (16 * s).clamp(13.0, 16.0),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: (12 * s).clamp(10.0, 14.0)),
                _InfoRow(
                  icon: Icons.mail_outline_rounded,
                  label: "Email",
                  value: "maaya@email.com",
                  scale: s,
                ),
                SizedBox(height: (10 * s).clamp(8.0, 12.0)),
                _InfoRow(
                  icon: Icons.phone_outlined,
                  label: "Phone",
                  value: "+63 912 345 6789",
                  scale: s,
                ),
                SizedBox(height: (10 * s).clamp(8.0, 12.0)),
                _InfoRow(
                  icon: Icons.location_on_outlined,
                  label: "Location",
                  value: "Quezon City, Metro Manila",
                  scale: s,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double scale;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Container(
      padding: EdgeInsets.fromLTRB(12 * s, 10 * s, 12 * s, 10 * s),
      decoration: BoxDecoration(
        color: const Color(0xFFF6FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: LIGHT_PRIMARY.withOpacity(0.35),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: SECONDARY.withOpacity(0.9),
            size: (18 * s).clamp(16.0, 20.0),
          ),
          SizedBox(width: (10 * s).clamp(8.0, 12.0)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: SECONDARY.withOpacity(0.85),
                    fontSize: (11.5 * s).clamp(11.0, 13.0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    color: PRIMARY.withOpacity(0.9),
                    fontSize: (12.5 * s).clamp(12.0, 14.0),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final double scale;
  final VoidCallback onPressed;

  const _LogoutButton({
    required this.scale,
    required this.onPressed,
  });

  @override
  @override
Widget build(BuildContext context) {
  final s = scale;

  return LayoutBuilder(
    builder: (context, constraints) {
      final btnW = constraints.maxWidth * 0.92; 

      return Center(
        child: SizedBox(
          width: btnW,
          height: (48 * s).clamp(44.0, 54.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFE7000B),
                  Color(0xFFFF0000),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE7000B).withOpacity(0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.logout_rounded, color: TEXT_COLOR_WHITE),
              label: Text(
                "Logout",
                style: TextStyle(
                  color: TEXT_COLOR_WHITE,
                  fontSize: (14 * s).clamp(13.0, 15.0),
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

}

double _scaleForWidth(double width) {
  if (width >= 900) return 1.12;
  if (width >= 700) return 1.08;
  if (width >= 500) return 1.04;
  return 1.0;
}
