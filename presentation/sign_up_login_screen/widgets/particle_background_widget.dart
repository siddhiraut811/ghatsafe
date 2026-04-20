import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class _Particle {
  double x, y, radius, speed, opacity, angle;
  _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.opacity,
    required this.angle,
  });
}

class ParticleBackgroundWidget extends StatefulWidget {
  const ParticleBackgroundWidget({super.key});

  @override
  State<ParticleBackgroundWidget> createState() =>
      _ParticleBackgroundWidgetState();
}

class _ParticleBackgroundWidgetState extends State<ParticleBackgroundWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final _rand = math.Random();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 60; i++) {
      _particles.add(
        _Particle(
          x: _rand.nextDouble(),
          y: _rand.nextDouble(),
          radius: _rand.nextDouble() * 2.5 + 0.5,
          speed: _rand.nextDouble() * 0.0002 + 0.00005,
          opacity: _rand.nextDouble() * 0.4 + 0.05,
          angle: _rand.nextDouble() * math.pi * 2,
        ),
      );
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();
    _controller.addListener(
      () => setState(() {
        for (var p in _particles) {
          p.x += math.cos(p.angle) * p.speed;
          p.y += math.sin(p.angle) * p.speed;
          if (p.x < 0) p.x = 1.0;
          if (p.x > 1) p.x = 0.0;
          if (p.y < 0) p.y = 1.0;
          if (p.y > 1) p.y = 0.0;
        }
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ParticlePainter(_particles),
      size: Size.infinite,
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final paint = Paint()
        ..color = Colors.white.withOpacity(p.opacity)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(p.x * size.width, p.y * size.height),
        p.radius,
        paint,
      );
    }
    // Subtle gradient overlay
    final gradient = RadialGradient(
      center: const Alignment(0, -0.5),
      radius: 0.8,
      colors: [AppTheme.dangerRed.withOpacity(0.08), Colors.transparent],
    );
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(
      rect,
      Paint()
        ..shader = gradient.createShader(rect)
        ..blendMode = BlendMode.srcOver,
    );
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
