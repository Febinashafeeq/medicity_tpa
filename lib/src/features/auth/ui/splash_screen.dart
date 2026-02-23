import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../shared/theme/app_colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Start progress after icon animation
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _progressController.forward();
    });

    // Navigate to login
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) context.go('/login');
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background ──────────────────────────────────────
          _SplashBackground(),

          // ── Center content ──────────────────────────────────
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Icon
              _AppIcon()
                  .animate()
                  .scale(
                begin: const Offset(0.7, 0.7),
                end: const Offset(1.0, 1.0),
                duration: 600.ms,
                curve: Curves.easeOutBack,
              )
                  .fadeIn(duration: 500.ms),

              const SizedBox(height: 28),

              // App Name
              Text(
                'MediAssure',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              )
                  .animate(delay: 300.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.3, end: 0, duration: 500.ms, curve: Curves.easeOut),

              const SizedBox(height: 10),

              // Tagline
              Text(
                'Trusted Healthcare Assurance',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.72),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3,
                ),
              )
                  .animate(delay: 500.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.3, end: 0, duration: 500.ms, curve: Curves.easeOut),

              const SizedBox(height: 64),

              // Progress Bar
              _ProgressBar(controller: _progressController)
                  .animate(delay: 700.ms)
                  .fadeIn(duration: 400.ms),
            ],
          ),

          // ── Version tag (top right) ──────────────────────────
          Positioned(
            top: 28,
            right: 32,
            child: Text(
              'v1.0.0',
              style: TextStyle(
                color: Colors.white.withOpacity(0.35),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ).animate(delay: 200.ms).fadeIn(duration: 400.ms),
          ),

          // ── Bottom powered-by ────────────────────────────────
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Powered by HealthTech Solutions  ·  Secure & HIPAA Ready',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.42),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3,
                ),
              ).animate(delay: 600.ms).fadeIn(duration: 500.ms),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Background with pattern & glow ──────────────────────────────────────────
class _SplashBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0B833D),
            Color(0xFF076B30),
            Color(0xFF054D23),
          ],
          stops: [0.0, 0.6, 1.0],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Grid pattern
          CustomPaint(painter: _GridPatternPainter()),

          // Radial glow center
          Center(
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.07),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Top-left circle decoration
          Positioned(
            top: -120,
            left: -120,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),

          // Bottom-right circle decoration
          Positioned(
            bottom: -120,
            right: -120,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),

          // Top-right smaller circle
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.07),
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Grid pattern painter ─────────────────────────────────────────────────────
class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 1;

    const step = 40.0;

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── App Icon ────────────────────────────────────────────────────────────────
class _AppIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: _MedicalShieldIcon(size: 52, color: AppColors.primary),
    );
  }
}

// ── Medical Shield SVG-like icon ────────────────────────────────────────────
class _MedicalShieldIcon extends StatelessWidget {
  final double size;
  final Color color;
  const _MedicalShieldIcon({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _ShieldPainter(color: color)),
    );
  }
}

class _ShieldPainter extends CustomPainter {
  final Color color;
  const _ShieldPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final w = size.width;
    final h = size.height;

    // Shield shape
    final shieldPath = Path()
      ..moveTo(w * 0.5, 0)
      ..lineTo(w * 0.05, h * 0.18)
      ..lineTo(w * 0.05, h * 0.52)
      ..cubicTo(w * 0.05, h * 0.80, w * 0.25, h * 0.95, w * 0.5, h)
      ..cubicTo(w * 0.75, h * 0.95, w * 0.95, h * 0.80, w * 0.95, h * 0.52)
      ..lineTo(w * 0.95, h * 0.18)
      ..close();

    canvas.drawPath(shieldPath, paint);

    // Cross - vertical bar
    final crossPaint = Paint()..color = Colors.white;
    final crossRadius = Radius.circular(w * 0.06);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.43, h * 0.28, w * 0.14, h * 0.44),
        crossRadius,
      ),
      crossPaint,
    );

    // Cross - horizontal bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.28, h * 0.43, w * 0.44, h * 0.14),
        crossRadius,
      ),
      crossPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Progress Bar ────────────────────────────────────────────────────────────
class _ProgressBar extends StatelessWidget {
  final AnimationController controller;
  const _ProgressBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: controller.value,
                  minHeight: 3,
                  backgroundColor: Colors.white.withOpacity(0.25),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}