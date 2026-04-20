import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../sos_screen.dart';

class SOSTriggerButtonWidget extends StatelessWidget {
  final SOSState sosState;
  final int countdown;
  final AnimationController rippleController;
  final VoidCallback onTap;
  final VoidCallback onCancel;
  final VoidCallback onReset;

  const SOSTriggerButtonWidget({
    super.key,
    required this.sosState,
    required this.countdown,
    required this.rippleController,
    required this.onTap,
    required this.onCancel,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ripple rings
          if (sosState == SOSState.active || sosState == SOSState.confirming)
            ...List.generate(3, (i) {
              final delay = i * 0.33;
              return AnimatedBuilder(
                animation: rippleController,
                builder: (_, __) {
                  final t = ((rippleController.value - delay) % 1.0).clamp(
                    0.0,
                    1.0,
                  );
                  return Transform.scale(
                    scale: 1.0 + t * 1.0,
                    child: Opacity(
                      opacity: (1 - t) * 0.4,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: sosState == SOSState.active
                                ? AppTheme.dangerRed
                                : AppTheme.warningAmber,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          // Main button
          GestureDetector(
            onTap: sosState == SOSState.idle ? onTap : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: sosState == SOSState.active
                    ? const RadialGradient(
                        colors: [Color(0xFFFF6B6B), AppTheme.dangerRed],
                      )
                    : sosState == SOSState.confirming
                    ? const RadialGradient(
                        colors: [Color(0xFFFFB347), AppTheme.warningAmber],
                      )
                    : const RadialGradient(
                        colors: [Color(0xFFFF6B6B), Color(0xFFCC1100)],
                      ),
                boxShadow: [
                  BoxShadow(
                    color:
                        (sosState == SOSState.active
                                ? AppTheme.dangerRed
                                : sosState == SOSState.confirming
                                ? AppTheme.warningAmber
                                : AppTheme.dangerRed)
                            .withOpacity(0.5),
                    blurRadius: 40,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    sosState == SOSState.active
                        ? Icons.cell_tower_rounded
                        : Icons.sos_rounded,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sosState == SOSState.active
                        ? 'SOS ACTIVE'
                        : sosState == SOSState.confirming
                        ? '$countdown'
                        : 'SOS',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: sosState == SOSState.confirming ? 36 : 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: sosState == SOSState.confirming ? 0 : 2,
                    ),
                  ),
                  if (sosState == SOSState.idle)
                    Text(
                      'PRESS TO ACTIVATE',
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                        letterSpacing: 1,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
