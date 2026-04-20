import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class RoadConditionsWidget extends StatelessWidget {
  const RoadConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceGlass,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.glassBorder, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.warningAmber.withAlpha(31),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.terrain_rounded,
                      size: 13,
                      color: AppTheme.warningAmber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Lonavala–Khandala Ghat',
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.warningAmber,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Updated 2 min ago',
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 10,
                  color: AppTheme.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildConditionRow(
            icon: Icons.water_drop_rounded,
            label: 'Surface',
            value: 'Wet — recent rain',
            color: AppTheme.infoBlue,
          ),
          const SizedBox(height: 10),
          _buildConditionRow(
            icon: Icons.air_rounded,
            label: 'Wind',
            value: '18 km/h — crosswind',
            color: AppTheme.warningAmber,
          ),
          const SizedBox(height: 10),
          _buildConditionRow(
            icon: Icons.thermostat_rounded,
            label: 'Temperature',
            value: '19°C',
            color: AppTheme.safeGreen,
          ),
          const SizedBox(height: 10),
          _buildConditionRow(
            icon: Icons.visibility_rounded,
            label: 'Visibility',
            value: '280m — Fog warning',
            color: AppTheme.dangerRed,
          ),
          const SizedBox(height: 14),
          _buildRecommendationBanner(),
        ],
      ),
    );
  }

  Widget _buildConditionRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withAlpha(31),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: GoogleFonts.ibmPlexSans(
              fontSize: 12,
              color: AppTheme.textMuted,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.ibmPlexSans(
              fontSize: 12,
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.warningAmber.withAlpha(20),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.warningAmber.withAlpha(64),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.tips_and_updates_rounded,
            size: 16,
            color: AppTheme.warningAmber,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Reduce speed. Wet surface + fog ahead. Use headlights.',
              style: GoogleFonts.ibmPlexSans(
                fontSize: 12,
                color: AppTheme.warningAmber,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
