import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class SpeedGaugeWidget extends StatelessWidget {
  final double currentSpeed;
  final int speedLimit;
  final bool isOverSpeed;
  final Animation<double> pulseAnimation;

  const SpeedGaugeWidget({
    super.key,
    required this.currentSpeed,
    required this.speedLimit,
    required this.isOverSpeed,
    required this.pulseAnimation,
  });

  Color get _speedColor {
    if (currentSpeed <= speedLimit * 0.75) return AppTheme.safeGreen;
    if (currentSpeed <= speedLimit) return AppTheme.warningAmber;
    return AppTheme.dangerRed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceGlass,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isOverSpeed
              ? AppTheme.dangerRed.withAlpha(102)
              : AppTheme.glassBorder,
          width: 1,
        ),
        boxShadow: [
          if (isOverSpeed)
            BoxShadow(
              color: AppTheme.dangerRed.withAlpha(38),
              blurRadius: 24,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.speed_rounded, size: 16, color: _speedColor),
              const SizedBox(width: 6),
              Text(
                'Current Speed',
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textMuted,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.warningAmber.withAlpha(31),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.warningAmber.withAlpha(77),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_rounded,
                      size: 12,
                      color: AppTheme.warningAmber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Limit: $speedLimit km/h',
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.warningAmber,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: CustomPaint(
              painter: _SpeedArcPainter(
                speed: currentSpeed,
                limit: speedLimit.toDouble(),
                color: _speedColor,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      currentSpeed.toStringAsFixed(0),
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 52,
                        fontWeight: FontWeight.w700,
                        color: _speedColor,
                        height: 1,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    Text(
                      'km/h',
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.textMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _speedColor.withAlpha(38),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isOverSpeed
                            ? '▲ ${(currentSpeed - speedLimit).toStringAsFixed(0)} km/h over limit'
                            : '✓ Within speed limit',
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _speedColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildSpeedBar(context),
        ],
      ),
    );
  }

  Widget _buildSpeedBar(BuildContext context) {
    final pct = (currentSpeed / (speedLimit * 1.5)).clamp(0.0, 1.0);
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0',
              style: GoogleFonts.ibmPlexSans(
                fontSize: 10,
                color: AppTheme.textMuted,
              ),
            ),
            Text(
              '$speedLimit',
              style: GoogleFonts.ibmPlexSans(
                fontSize: 10,
                color: AppTheme.warningAmber,
              ),
            ),
            Text(
              '${(speedLimit * 1.5).toInt()}',
              style: GoogleFonts.ibmPlexSans(
                fontSize: 10,
                color: AppTheme.dangerRed,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(20),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            FractionallySizedBox(
              widthFactor: pct,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.safeGreen, _speedColor],
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            Positioned(
              left: (speedLimit / (speedLimit * 1.5)) * (screenWidth - 80),
              child: Container(
                width: 2,
                height: 10,
                margin: const EdgeInsets.only(top: -2),
                decoration: BoxDecoration(
                  color: AppTheme.warningAmber,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SpeedArcPainter extends CustomPainter {
  final double speed;
  final double limit;
  final Color color;

  _SpeedArcPainter({
    required this.speed,
    required this.limit,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.85);
    final radius = size.width * 0.42;
    const startAngle = math.pi;
    const sweepAngle = math.pi;

    final bgPaint = Paint()
      ..color = Colors.white.withAlpha(15)
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    final limitFraction = limit / (limit * 1.5);
    final limitAngle = startAngle + sweepAngle * limitFraction;
    final markerPaint = Paint()
      ..color = AppTheme.warningAmber
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final markerStart = Offset(
      center.dx + (radius - 18) * math.cos(limitAngle),
      center.dy + (radius - 18) * math.sin(limitAngle),
    );
    final markerEnd = Offset(
      center.dx + (radius + 4) * math.cos(limitAngle),
      center.dy + (radius + 4) * math.sin(limitAngle),
    );
    canvas.drawLine(markerStart, markerEnd, markerPaint);

    final speedFraction = (speed / (limit * 1.5)).clamp(0.0, 1.0);
    final speedSweep = sweepAngle * speedFraction;
    final speedPaint = Paint()
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: startAngle,
        endAngle: startAngle + speedSweep,
        colors: [AppTheme.safeGreen, color],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      speedSweep,
      false,
      speedPaint,
    );

    final needleAngle = startAngle + speedSweep;
    final tipPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(
        center.dx + radius * math.cos(needleAngle),
        center.dy + radius * math.sin(needleAngle),
      ),
      8,
      tipPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _SpeedArcPainter oldDelegate) =>
      oldDelegate.speed != speed || oldDelegate.color != color;
}
