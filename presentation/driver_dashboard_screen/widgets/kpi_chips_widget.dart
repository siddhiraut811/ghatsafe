import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class KpiChipsWidget extends StatelessWidget {
  final bool isOverSpeed;

  const KpiChipsWidget({super.key, required this.isOverSpeed});

  @override
  Widget build(BuildContext context) {
    final chips = [
      _KpiData(
        icon: Icons.help_outline,
        label: 'Road Status',
        value: 'Caution',
        color: AppTheme.warningAmber,
      ),
      _KpiData(
        icon: Icons.visibility_rounded,
        label: 'Visibility',
        value: '280m',
        color: AppTheme.infoBlue,
      ),
      _KpiData(
        icon: Icons.local_hospital_rounded,
        label: 'Help Center',
        value: '4.2 km',
        color: AppTheme.safeGreen,
      ),
      _KpiData(
        icon: Icons.report_problem_rounded,
        label: 'Hazard Ahead',
        value: '1.1 km',
        color: AppTheme.dangerRed,
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.4,
      children: chips.map((c) => _KpiChip(data: c)).toList(),
    );
  }
}

class _KpiData {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _KpiData({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
}

class _KpiChip extends StatelessWidget {
  final _KpiData data;
  const _KpiChip({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: data.color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: data.color.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: data.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(data.icon, size: 16, color: data.color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.value,
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: data.color,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                Text(
                  data.label,
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.textMuted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
