import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/bottom_nav.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
    required this.primary,
    required this.primarySoft,
    required this.bgTop,
    required this.bgMid,
    required this.bgBottom,
    required this.cardColor,
    required this.textDark,
    required this.textMuted,
    this.showBottomNav = false, 
  });

  
  final Color primary;
  final Color primarySoft;
  final Color bgTop;
  final Color bgMid;
  final Color bgBottom;
  final Color cardColor;
  final Color textDark;
  final Color textMuted;
  final bool showBottomNav;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _first = TextEditingController(text: "Cham");
  final _last = TextEditingController(text: "Maaya");
  final _email = TextEditingController(text: "maaya@email.com");
  final _phone = TextEditingController(text: "+63 912 345 6789");
  final _location = TextEditingController(text: "Quezon City, Metro Manila");

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _email.dispose();
    _phone.dispose();
    _location.dispose();
    super.dispose();
  }

  double _scaleForWidth(double w) {
    if (w >= 420) return 1.0;
    if (w >= 380) return 0.96;
    if (w >= 350) return 0.92;
    return 0.88;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: const BoxDecoration(
        gradient: LinearGradient(
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
        bottomNavigationBar:
            widget.showBottomNav ? const HealthCastBottomNav(currentIndex: 4) : null,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, c) {
              final w = c.maxWidth;
              final s = _scaleForWidth(w);
              final padX = (w * 0.06).clamp(16.0, 26.0);

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(padX, 14 * s, padX, 24 * s),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      padding: EdgeInsets.all(10 * s),
                      child: Container(
                       
                        padding:
                            EdgeInsets.fromLTRB(14 * s, 14 * s, 14 * s, 16 * s),
                        decoration: BoxDecoration(
                          color: TEXT_COLOR_WHITE,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: PRIMARY.withOpacity(0.15),
                              blurRadius: 22,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                           
                            Row(
                              children: [
                                _CloseCircle(
                                  scale: s,
                                  border: LIGHT_PRIMARY,
                                  iconColor: PRIMARY,
                                  onTap: () => Navigator.pop(context),
                                ),
                                SizedBox(width: 10 * s),
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    fontSize: 15.5 * s,
                                    fontWeight: FontWeight.w500,
                                    color: PRIMARY,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12 * s),

                            
                            _AvatarBanner(
                              scale: s,
                              initials: "CM",
                              onCameraTap: () {
                                // TODO: open image picker
                              },
                            ),
                            SizedBox(height: 12 * s),

                            
                            _Field(
                              scale: s,
                              label: "First Name",
                              icon: Icons.person_outline_rounded,
                              controller: _first,
                            ),
                            SizedBox(height: 10 * s),
                            _Field(
                              scale: s,
                              label: "Last Name",
                              icon: Icons.person_outline_rounded,
                              controller: _last,
                            ),
                            SizedBox(height: 10 * s),
                            _Field(
                              scale: s,
                              label: "Email Address",
                              icon: Icons.mail_outline_rounded,
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 10 * s),
                            _Field(
                              scale: s,
                              label: "Phone Number",
                              icon: Icons.call_outlined,
                              controller: _phone,
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(height: 10 * s),
                            _Field(
                              scale: s,
                              label: "Location",
                              icon: Icons.location_on_outlined,
                              controller: _location,
                            ),
                            SizedBox(height: 14 * s),

                            
                            _PrimaryButton(
                              scale: s,
                              text: "Save Changes",
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Saved (demo)")),
                                );
                              },
                            ),
                            SizedBox(height: 10 * s),

                            
                            _GhostButton(
                              scale: s,
                              text: "Cancel",
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}



class _CloseCircle extends StatelessWidget {
  const _CloseCircle({
    required this.scale,
    required this.border,
    required this.iconColor,
    required this.onTap,
  });

  final double scale;
  final Color border;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return InkWell(
      borderRadius: BorderRadius.circular(99),
      onTap: onTap,
      child: Container(
        width: 34 * s,
        height: 34 * s,
        decoration: BoxDecoration(
          color: TEXT_COLOR_WHITE,
          shape: BoxShape.circle,
          border: Border.all(color: border.withOpacity(0.75), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Icon(Icons.close_rounded, size: 18 * s, color: iconColor),
      ),
    );
  }
}

class _AvatarBanner extends StatelessWidget {
  const _AvatarBanner({
    required this.scale,
    required this.initials,
    required this.onCameraTap,
  });

  final double scale;
  final String initials;
  final VoidCallback onCameraTap;

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Container(
      height: (118 * s).clamp(108.0, 132.0),
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
      ),
      child: Stack(
        children: [
          
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 68 * s,
              height: 68 * s,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: TEXT_COLOR_WHITE.withOpacity(0.18),
                border: Border.all(
                  color: TEXT_COLOR_WHITE.withOpacity(0.35),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  initials,
                  style: TextStyle(
                    color: TEXT_COLOR_WHITE,
                    fontSize: 18 * s,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),

         
          Positioned(
            right: 18 * s,
            top: 38 * s,
            child: InkWell(
              onTap: onCameraTap,
              borderRadius: BorderRadius.circular(99),
              // child: Container(
              //   width: 34 * s,
              //   height: 34 * s,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: TEXT_COLOR_WHITE.withOpacity(0.18),
              //     border: Border.all(
              //       color: TEXT_COLOR_WHITE.withOpacity(0.35),
              //       width: 1,
              //     ),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.10),
              //         blurRadius: 10,
              //         offset: const Offset(0, 6),
              //       ),
              //     ],
              //   ),
              //   child: Icon(
              //     Icons.photo_camera_outlined,
              //     size: 18 * s,
              //     color: TEXT_COLOR_WHITE,
              //   ),
              // ),
            ),
          ),

          
          Positioned(
            bottom: 10 * s,
            left: 0,
            right: 0,
            child: Center(
              // child: Text(
              //   "Tap camera icon to change avatar",
              //   style: TextStyle(
              //     fontSize: 11.5 * s,
              //     color: TEXT_COLOR_WHITE.withOpacity(0.85),
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.scale,
    required this.label,
    required this.icon,
    required this.controller,
    this.keyboardType,
  });

  final double scale;
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5 * s,
            color: SECONDARY.withOpacity(0.85),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6 * s),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(
            fontSize: 13.2 * s,
            fontWeight: FontWeight.w400,
            color: PRIMARY.withOpacity(0.90),
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18 * s, color: SECONDARY.withOpacity(0.90)),
            filled: true,
            fillColor: const Color(0xFFF6FAFC),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12 * s,
              vertical: 12 * s,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: LIGHT_PRIMARY.withOpacity(0.35), width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: PRIMARY, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.scale,
    required this.text,
    required this.onTap,
  });

  final double scale;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: (46 * s).clamp(44.0, 52.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              PRIMARY,
              DARK_PRIMARY,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: PRIMARY.withOpacity(0.18),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.save_outlined, color: TEXT_COLOR_WHITE, size: 18 * s),
            SizedBox(width: 8 * s),
            Text(
              text,
              style: TextStyle(
                fontSize: 13.6 * s,
                fontWeight: FontWeight.w500,
                color: TEXT_COLOR_WHITE,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({
    required this.scale,
    required this.text,
    required this.onTap,
  });

  final double scale;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: (46 * s).clamp(44.0, 52.0),
        decoration: BoxDecoration(
          color: TEXT_COLOR_WHITE,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: LIGHT_PRIMARY.withOpacity(0.85), width: 1),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.4 * s,
              fontWeight: FontWeight.w500,
              color: PRIMARY.withOpacity(0.82),
            ),
          ),
        ),
      ),
    );
  }
}
