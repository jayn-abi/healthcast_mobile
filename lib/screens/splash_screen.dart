import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../constants.dart';

class SplashScreen extends StatefulWidget {

  final String nextRoute;

  
  final Duration duration;

  const SplashScreen({
    super.key,
    required this.nextRoute,
    this.duration = const Duration(milliseconds: 4000),
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _main;
  late final AnimationController _particlesCtrl;
  late final AnimationController _ringCtrl;
  late final AnimationController _lineCtrl;

  
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _titleOpacity;
  late final Animation<double> _titleSlide;
  late final Animation<double> _tagOpacity;
  late final Animation<double> _tagSlide;

  late final Animation<double> _contentFadeOut;

  
  late final Animation<double> _flash;

  @override
  void initState() {
    super.initState();

    _main = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _particlesCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();

    _ringCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();

    _lineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _logoOpacity = CurvedAnimation(
      parent: _main,
      curve: const Interval(0.12, 0.30, curve: Curves.easeOut),
    );

    _logoScale = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(
        parent: _main,
        curve: const Interval(0.12, 0.35, curve: Curves.easeOutBack),
      ),
    );

    _titleOpacity = CurvedAnimation(
      parent: _main,
      curve: const Interval(0.22, 0.40, curve: Curves.easeOut),
    );

    _titleSlide = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: _main,
        curve: const Interval(0.22, 0.42, curve: Curves.easeOutCubic),
      ),
    );

    _tagOpacity = CurvedAnimation(
      parent: _main,
      curve: const Interval(0.30, 0.48, curve: Curves.easeOut),
    );

    _tagSlide = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: _main,
        curve: const Interval(0.30, 0.50, curve: Curves.easeOutCubic),
      ),
    );

    
    _contentFadeOut = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _main,
        curve: const Interval(0.68, 0.82, curve: Curves.easeInOut),
      ),
    );

    
    _flash = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _main,
        curve: const Interval(0.74, 0.88, curve: Curves.easeOut),
      ),
    );

    _main.forward();

    _main.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Navigator.pushReplacementNamed(context, widget.nextRoute);
      }
    });
  }

  @override
  void dispose() {
    _main.dispose();
    _particlesCtrl.dispose();
    _ringCtrl.dispose();
    _lineCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Stack(
        children: [
          const _SplashBackground(),

          
          AnimatedBuilder(
            animation: _particlesCtrl,
            builder: (_, __) => CustomPaint(
              size: size,
              painter: _ParticlesPainter(t: _particlesCtrl.value),
            ),
          ),

          
          SafeArea(
            child: Center(
              child: AnimatedBuilder(
                animation: _main,
                builder: (_, __) {
                  final fadeAll = _contentFadeOut.value;

                  return Opacity(
                    opacity: fadeAll,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        
                        Opacity(
                          opacity: _logoOpacity.value,
                          child: Transform.scale(
                            scale: _logoScale.value,
                            child: _LogoWithRings(
                              ringT: _ringCtrl,
                              logo: Image.asset(
                                "assets/images/logo.png",
                                width: 74,
                                height: 74,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                       
                        Opacity(
                          opacity: _titleOpacity.value,
                          child: Transform.translate(
                            offset: Offset(0, _titleSlide.value),
                            child: Text(
                              "HealthCast",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                                color: TEXT_COLOR_WHITE.withOpacity(0.95),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        
                        Opacity(
                          opacity: _tagOpacity.value,
                          child: Transform.translate(
                            offset: Offset(0, _tagSlide.value),
                            child: Text(
                              "Powering Health Intelligence",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.5,
                                height: 1.2,
                                fontWeight: FontWeight.w500,
                                color: TEXT_COLOR_WHITE.withOpacity(0.62),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        
                        Opacity(
                          opacity: (_tagOpacity.value * 0.95).clamp(0, 1),
                          child: _LoadingLine(ctrl: _lineCtrl),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          
          IgnorePointer(
            child: AnimatedBuilder(
              animation: _flash,
              builder: (_, __) => Opacity(
                opacity: _flash.value,
                child: Container(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashBackground extends StatelessWidget {
  const _SplashBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            PRIMARY,
            DARK_PRIMARY,
            SECONDARY.withOpacity(0.55),
          ],
          stops: const [0.0, 0.55, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(-0.8, -0.9),
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    LIGHT_PRIMARY.withOpacity(0.28),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.8, 0.9),
            child: Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    SECONDARY.withOpacity(0.18),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoWithRings extends StatelessWidget {
  final Animation<double> ringT;
  final Widget logo;

  const _LogoWithRings({
    required this.ringT,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: 140,
      height: 140,
      child: AnimatedBuilder(
        animation: ringT,
        builder: (_, __) {
          final t1 = ringT.value;
          final t2 = (ringT.value + 0.45) % 1.0;

          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 34,
                      spreadRadius: 4,
                      color: LIGHT_PRIMARY.withOpacity(0.22),
                    ),
                  ],
                ),
              ),

              _Ring(t: t1),
              _Ring(t: t2),

              Container(
                width: 78,
                height: 78,
                decoration: BoxDecoration(
                  color: TEXT_COLOR_WHITE.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                      color: Colors.black.withOpacity(0.20),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: logo,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  final double t; // 0..1
  const _Ring({required this.t});

  @override
  Widget build(BuildContext context) {
    final opacity = (1 - t).clamp(0.0, 1.0) * 0.38;

    
    return Transform.scale(
      scale: 1.0 + (t * 0.55),
      child: Container(
        width: 92,
        height: 92,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: TEXT_COLOR_WHITE.withOpacity(opacity),
            width: 2,
          ),
        ),
      ),
    );
  }
}

class _LoadingLine extends StatelessWidget {
  final Animation<double> ctrl;
  const _LoadingLine({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: TEXT_COLOR_WHITE.withOpacity(0.18),
              ),
            ),
            AnimatedBuilder(
              animation: ctrl,
              builder: (_, __) {
                final x = ctrl.value; 
                return FractionalTranslation(
                  translation: Offset(-1.0 + (2.0 * x), 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 60,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            TEXT_COLOR_WHITE.withOpacity(0.75),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


class _ParticlesPainter extends CustomPainter {
  final double t;
  _ParticlesPainter({required this.t});

  static final _rng = math.Random(7);

  static final List<_P> _particles = List.generate(85, (i) {
    return _P(
      x: _rng.nextDouble(),
      y: _rng.nextDouble(),
      r: 0.6 + _rng.nextDouble() * 1.6,
      a: 0.18 + _rng.nextDouble() * 0.55,
      drift: 0.18 + _rng.nextDouble() * 0.55,
    );
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final p in _particles) {
      final dy = (p.drift * t);
      final dx = (p.drift * 0.35 * t);

      final x = ((p.x + dx) % 1.0) * size.width;
      final y = ((p.y - dy) % 1.0) * size.height;

      paint.color = TEXT_COLOR_WHITE.withOpacity(p.a);
      canvas.drawCircle(Offset(x, y), p.r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter oldDelegate) => true;
}

class _P {
  final double x, y, r, a, drift;
  _P({
    required this.x,
    required this.y,
    required this.r,
    required this.a,
    required this.drift,
  });
}
