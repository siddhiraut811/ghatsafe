import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class SOSBroadcastStatusWidget extends StatelessWidget {
  final AnimationController rippleController;

  const SOSBroadcastStatusWidget({super.key, required this.rippleController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.dangerRed.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.dangerRed.withOpacity(0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AnimatedBuilder(
                animation: rippleController,
                builder: (_, __) => Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppTheme.dangerRed.withOpacity(
                      0.5 + rippleController.value * 0.5,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.dangerRed.withOpacity(
                          rippleController.value * 0.6,
                        ),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'SOS Broadcast Active',
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.dangerRed,
                ),
              ),
              const Spacer(),
              Text(
                '00:42',
                style: GoogleFonts.ibmPlexMono(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.dangerRed,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildBroadcastItem(
            label: 'Maharashtra Police Emergency',
            status: 'Acknowledged',
            color: AppTheme.safeGreen,
            icon: Icons.local_police_rounded,
          ),
          const SizedBox(height: 8),
          _buildBroadcastItem(
            label: 'NHAI Incident Control',
            status: 'Received',
            color: AppTheme.infoBlue,
            icon: Icons.cell_tower_rounded,
          ),
          const SizedBox(height: 8),
          _buildBroadcastItem(
            label: 'Lonavala Civil Hospital',
            status: 'En Route',
            color: AppTheme.warningAmber,
            icon: Icons.local_hospital_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildBroadcastItem({
    required String label,
    required String status,
    required Color color,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.ibmPlexSans(
              fontSize: 12,
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            status,
            style: GoogleFonts.ibmPlexSans(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
