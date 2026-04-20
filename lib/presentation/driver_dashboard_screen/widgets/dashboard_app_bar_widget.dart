import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class DashboardAppBarWidget extends StatelessWidget {
  final int alertCount;
  final bool isOverSpeed;

  const DashboardAppBarWidget({
    super.key,
    required this.alertCount,
    required this.isOverSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.backgroundDark.withAlpha(179),
            border: const Border(
              bottom: BorderSide(color: AppTheme.glassBorder, width: 1),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: 64,
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.dangerRed, Color(0xFFFF6B35)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.shield_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GhatSafe',
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppTheme.safeGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Live Monitoring',
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 11,
                              color: AppTheme.textMuted,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (isOverSpeed)
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.dangerRed.withAlpha(38),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.dangerRed.withAlpha(102),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.speed_rounded,
                            size: 14,
                            color: AppTheme.dangerRed,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'OVERSPEED',
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.dangerRed,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: AppTheme.textPrimary,
                          size: 24,
                        ),
                        onPressed: () {},
                      ),
                      if (alertCount > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              color: AppTheme.dangerRed,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$alertCount',
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      color: AppTheme.textPrimary,
                      size: 24,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
