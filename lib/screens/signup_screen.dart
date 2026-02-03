import 'dart:ui' as ui;
import 'dart:ui'; 
import 'package:flutter/material.dart';
import 'package:healthcast/screens/login_screen.dart';
import '../constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstCtrl = TextEditingController();
  final _lastCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _obscure1 = true;
  bool _obscure2 = true;
  bool _agree = false;

  @override
  void dispose() {
    _firstCtrl.dispose();
    _lastCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _AuthScaffold(
        child: Column(
          children: [
            const SizedBox(height: 8),
            const _AuthHeader(
              title: "Create Account",
              subtitle: "Join HealthCast",
              logoAssetPath: "assets/images/logo.png",
            ),
            const SizedBox(height: 12),
            _AuthCard(
              child: Column(
                children: [
                  const _Label("First Name"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _firstCtrl,
                    textInputAction: TextInputAction.next,
                    decoration: _fieldDecoration(
                      hint: "John",
                      prefix: Icons.person_outline_rounded,
                    ),
                  ),
                  const SizedBox(height: 10),

                  const _Label("Last Name"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _lastCtrl,
                    textInputAction: TextInputAction.next,
                    decoration: _fieldDecoration(
                      hint: "Doe",
                      prefix: Icons.person_outline_rounded,
                    ),
                  ),
                  const SizedBox(height: 10),

                  const _Label("Email Address"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: _fieldDecoration(
                      hint: "johndoe@example.com",
                      prefix: Icons.mail_outline_rounded,
                    ),
                  ),
                  const SizedBox(height: 10),

                  const _Label("Phone Number"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: _fieldDecoration(
                      hint: "+63 912 345 6789",
                      prefix: Icons.phone_outlined,
                    ),
                  ),
                  const SizedBox(height: 10),

                  const _Label("Password"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passCtrl,
                    obscureText: _obscure1,
                    textInputAction: TextInputAction.next,
                    decoration: _fieldDecoration(
                      hint: "At least 8 characters",
                      prefix: Icons.lock_outline_rounded,
                      suffix: IconButton(
                        onPressed: () => setState(() => _obscure1 = !_obscure1),
                        icon: Icon(
                          _obscure1
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: DARK_PRIMARY.withOpacity(0.7),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  const _Label("Confirm Password"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _confirmCtrl,
                    obscureText: _obscure2,
                    textInputAction: TextInputAction.done,
                    decoration: _fieldDecoration(
                      hint: "Re-enter password",
                      prefix: Icons.lock_outline_rounded,
                      suffix: IconButton(
                        onPressed: () => setState(() => _obscure2 = !_obscure2),
                        icon: Icon(
                          _obscure2
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: DARK_PRIMARY.withOpacity(0.7),
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                          value: _agree,
                          onChanged: (v) => setState(() => _agree = v ?? false),
                          activeColor: DARK_PRIMARY,
                          side: BorderSide(color: DARK_PRIMARY.withOpacity(0.55)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Wrap(
                          children: [
                            Text(
                              "I agree to the ",
                              style: TextStyle(
                                color: DARK_PRIMARY.withOpacity(0.85),
                                fontSize: 12.5,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "Terms",
                                style: TextStyle(
                                  color: SECONDARY,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              " and ",
                              style: TextStyle(
                                color: DARK_PRIMARY.withOpacity(0.85),
                                fontSize: 12.5,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  color: SECONDARY,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  
                  
                  _GradientButton(
                    text: "Create Account",
                    onPressed: () {
                      // TODO sign up logic
                    },
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: DARK_PRIMARY.withOpacity(0.85),
                          fontSize: 12.5,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                            return;
                          }
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: DARK_PRIMARY,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class _AuthScaffold extends StatefulWidget {
  final Widget child;
  const _AuthScaffold({required this.child});

  @override
  State<_AuthScaffold> createState() => _AuthScaffoldState();
}

class _AuthScaffoldState extends State<_AuthScaffold>
    with TickerProviderStateMixin {
  late final AnimationController _bgCtrl;

  @override
  void initState() {
    super.initState();

    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat();
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final h = c.maxHeight;

        final scale = _scaleForWidth(w);
        final horizontalPadding = (w * 0.06).clamp(16.0, 28.0);
        final maxContentWidth = w >= 700 ? 520.0 : 460.0;

        return AnimatedBuilder(
          animation: _bgCtrl,
          builder: (context, _) {
            final t = _bgCtrl.value;

            final begin = const Alignment(-1.0, -1.0);
            final end = const Alignment(1.0, 1.0);

            final p1 = PRIMARY.withOpacity(0.95);
            final p2 = DARK_PRIMARY.withOpacity(0.92);
            final p3 = SECONDARY.withOpacity(0.90);

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: begin,
                  end: end,
                  stops: const [0.0, 0.55, 1.0],
                  colors: [p1, p2, p3],
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Stack(
                        children: [
                          _Blob(
                            x: 0.08 + 0.06 * _wave(t),
                            y: 0.12 + 0.05 * _wave(t + 0.25),
                            size: 260,
                            color: TEXT_COLOR_WHITE.withOpacity(0.16),
                            blur: 34,
                          ),
                          _Blob(
                            x: 0.72 + 0.08 * _wave(t + 0.35),
                            y: 0.22 + 0.07 * _wave(t + 0.70),
                            size: 220,
                            color: SECONDARY.withOpacity(0.18),
                            blur: 36,
                          ),
                          _Blob(
                            x: 0.58,
                            y: 0.78,
                            size: 300,
                            color: PRIMARY.withOpacity(0.18),
                            blur: 40,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 16 * scale,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: h - 32),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: maxContentWidth),
                            child: widget.child,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

double _wave(double t) {
  final v = (t % 1.0);
  final tri = v < 0.5 ? (v * 2) : (2 - v * 2);
  final curved = Curves.easeInOut.transform(tri);
  return (curved * 2) - 1;
}

class _Blob extends StatelessWidget {
  final double x;
  final double y;
  final double size;
  final Color color;
  final double blur;

  const _Blob({
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.blur,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    return Positioned(
      left: (w * x) - (size / 2),
      top: (h * y) - (size / 2),
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }
}




class _AuthHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String logoAssetPath;

  const _AuthHeader({
    required this.title,
    required this.subtitle,
    required this.logoAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final scale = _scaleForWidth(w);

    final logoSize = (90 * scale).clamp(70.0, 110.0);

    return Column(
      children: [
        SizedBox(
          width: logoSize,
          height: logoSize,
          child: Transform.scale(
            scale: 1.25,
            child: Image.asset(
              logoAssetPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: (12 * scale).clamp(8.0, 16.0)),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: TEXT_COLOR_WHITE,
            fontSize: (25 * scale).clamp(24.0, 34.0),
            fontWeight: FontWeight.w500,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: TextStyle(
              color: TEXT_COLOR_WHITE.withOpacity(0.75),
              fontSize: (13 * scale).clamp(12.0, 14.0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}

class _AuthCard extends StatelessWidget {
  final Widget child;
  const _AuthCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final scale = _scaleForWidth(w);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        20 * scale,
        18 * scale,
        20 * scale,
        18 * scale,
      ),
      decoration: BoxDecoration(
        color: TEXT_COLOR_WHITE,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}




class _GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const _GradientButton({
    required this.text,
    required this.onPressed,
  });

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 8200),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scale = _scaleForWidth(MediaQuery.sizeOf(context).width);
    final r = BorderRadius.circular(14);

    return SizedBox(
      width: double.infinity,
      height: (46 * scale).clamp(44.0, 54.0),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, _) {
          return Material(
            color: Colors.transparent,
            borderRadius: r,
            clipBehavior: Clip.antiAlias,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: r,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [DARK_PRIMARY, PRIMARY, SECONDARY],
                  stops: [0.0, 0.55, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: DARK_PRIMARY.withOpacity(0.22),
                    blurRadius: 16,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter: _OrbitOutlinePainter(
                          t: _ctrl.value,
                          radius: 14,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              TEXT_COLOR_WHITE.withOpacity(0.10),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.6],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: r,
                    onTap: widget.onPressed,
                    overlayColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.black.withOpacity(0.10);
                      }
                      return null;
                    }),
                    child: Center(
                      child: Text(
                        widget.text,
                        style: TextStyle(
                          color: TEXT_COLOR_WHITE,
                          fontSize: (14.5 * scale).clamp(13.5, 16.0),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OrbitOutlinePainter extends CustomPainter {
  final double t;
  final double radius;

  _OrbitOutlinePainter({
    required this.t,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(1.0, 1.0, size.width - 2.0, size.height - 2.0),
      Radius.circular(radius),
    );

    final basePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = TEXT_COLOR_WHITE.withOpacity(0.22);

    canvas.drawRRect(rrect, basePaint);

    final path = Path()..addRRect(rrect);
    final pm = path.computeMetrics().first;
    final total = pm.length;

    final headLen = total * 0.28;
    final start = t * total;
    final end = start + headLen;

    void drawSegment(double s, double e) {
      final seg = pm.extractPath(s, e);

      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = 7.0
        ..color = TEXT_COLOR_WHITE.withOpacity(0.22)
        ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 10);

      final midGlow = Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = 4.0
        ..color = TEXT_COLOR_WHITE.withOpacity(0.22)
        ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 5);

      final mainStroke = Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = 2.3
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent,
            TEXT_COLOR_WHITE.withOpacity(0.75),
            TEXT_COLOR_WHITE,
            TEXT_COLOR_WHITE.withOpacity(0.75),
            Colors.transparent,
          ],
          stops: const [0.0, 0.35, 0.50, 0.65, 1.0],
        ).createShader(rrect.outerRect);

      canvas.drawPath(seg, glowPaint);
      canvas.drawPath(seg, midGlow);
      canvas.drawPath(seg, mainStroke);
    }

    if (end <= total) {
      drawSegment(start, end);
    } else {
      drawSegment(start, total);
      drawSegment(0, end - total);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitOutlinePainter old) {
    return old.t != t || old.radius != radius;
  }
}




class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final scale = _scaleForWidth(w);

    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: DARK_PRIMARY.withOpacity(0.9),
          fontSize: (12.5 * scale).clamp(12.0, 14.0),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

InputDecoration _fieldDecoration({
  required String hint,
  required IconData prefix,
  Widget? suffix,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      color: DARK_PRIMARY.withOpacity(0.45),
      fontSize: 13,
    ),
    prefixIcon: Icon(prefix, color: DARK_PRIMARY.withOpacity(0.65), size: 20),
    suffixIcon: suffix,
    filled: true,
    fillColor: const Color(0xFFF6FAFC),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: LIGHT_PRIMARY.withOpacity(0.55), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: SECONDARY, width: 1.3),
    ),
  );
}

double _scaleForWidth(double width) {
  if (width >= 900) return 1.12;
  if (width >= 700) return 1.08;
  if (width >= 500) return 1.04;
  return 1.0;
}
