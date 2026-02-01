import 'package:flutter/material.dart';
import 'package:healthcast/screens/signup_screen.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _rememberMe = false;
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
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
              title: "HealthCast",
              subtitle: null,
              logoAssetPath: "assets/images/logo.png",
            ),
            const SizedBox(height: 18),
            _AuthCard(
              child: Column(
                children: [
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: DARK_PRIMARY,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 18),

                  const _Label("Email Address"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: _fieldDecoration(
                      hint: "you@example.com",
                      prefix: Icons.mail_outline_rounded,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const _Label("Password"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passCtrl,
                    obscureText: _obscure,
                    textInputAction: TextInputAction.done,
                    decoration: _fieldDecoration(
                      hint: "Enter your password",
                      prefix: Icons.lock_outline_rounded,
                      suffix: IconButton(
                        onPressed: () => setState(() => _obscure = !_obscure),
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: DARK_PRIMARY.withOpacity(0.7),
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            setState(() => _rememberMe = !_rememberMe),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 22,
                              height: 22,
                              child: Checkbox(
                                value: _rememberMe,
                                onChanged: (v) => setState(
                                    () => _rememberMe = v ?? false),
                                activeColor: DARK_PRIMARY,
                                side: BorderSide(
                                  color: DARK_PRIMARY.withOpacity(0.55),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Remember me",
                              style: TextStyle(
                                color: DARK_PRIMARY.withOpacity(0.9),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // TODO forgot password
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          foregroundColor: SECONDARY,
                        ),
                        child: const Text(
                          "Forgot?",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                 _GradientButton(
                    text: "Login",
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/weather');
                    },
                  ),


                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: DARK_PRIMARY.withOpacity(0.85),
                          fontSize: 12.5,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign up",
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


class _AuthScaffold extends StatelessWidget {
  final Widget child;
  const _AuthScaffold({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final h = c.maxHeight;

        final scale = _scaleForWidth(w);
        final horizontalPadding = (w * 0.06).clamp(16.0, 28.0);
        final maxContentWidth = w >= 700 ? 520.0 : 460.0;

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [PRIMARY, DARK_PRIMARY, SECONDARY],
            ),
          ),
          child: SafeArea(
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
                    child: child,
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
            fontSize: (30 * scale).clamp(24.0, 34.0),
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

class _GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _GradientButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final scale = _scaleForWidth(w);

    return SizedBox(
      width: double.infinity,
      height: (44 * scale).clamp(42.0, 50.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              DARK_PRIMARY.withOpacity(0.92),
              PRIMARY.withOpacity(0.92),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: PRIMARY.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: TEXT_COLOR_WHITE,
              fontSize: (14 * scale).clamp(13.0, 15.0),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
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
