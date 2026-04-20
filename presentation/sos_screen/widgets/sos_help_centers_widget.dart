import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class _HelpCenter {
  final String id;
  final String name;
  final String type;
  final String distance;
  final String eta;
  final String phone;
  final bool isAvailable;
  final IconData icon;
  final Color color;

  const _HelpCenter({
    required this.id,
    required this.name,
    required this.type,
    required this.distance,
    required this.eta,
    required this.phone,
    required this.isAvailable,
    required this.icon,
    required this.color,
  });
}

class SOSHelpCentersWidget extends StatelessWidget {
  const SOSHelpCentersWidget({super.key});

  static const List<_HelpCenter> _centers = [
    _HelpCenter(
      id: 'HC-001',
      name: 'Lonavala Police Station',
      type: 'Police Emergency',
      distance: '4.2 km',
      eta: '8 min',
      phone: '100',
      isAvailable: true,
      icon: Icons.local_police_rounded,
      color: AppTheme.infoBlue,
    ),
    _HelpCenter(
      id: 'HC-002',
      name: 'Lonavala Civil Hospital',
      type: 'Medical Emergency',
      distance: '6.8 km',
      eta: '12 min',
      phone: '108',
      isAvailable: true,
      icon: Icons.local_hospital_rounded,
      color: AppTheme.dangerRed,
    ),
    _HelpCenter(
      id: 'HC-003',
      name: 'NHAI Control Room — NH48',
      type: 'Highway Incident',
      distance: '11.3 km',
      eta: '18 min',
      phone: '1033',
      isAvailable: true,
      icon: Icons.cell_tower_rounded,
      color: AppTheme.warningAmber,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.emergency_rounded,
              size: 16,
              color: AppTheme.dangerRed,
            ),
            const SizedBox(width: 8),
            Text(
              'Nearest Help Centers',
              style: GoogleFonts.ibmPlexSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppTheme.safeGreen.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${_centers.length} available',
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.safeGreen,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._centers.map(
          (c) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _HelpCenterCard(center: c),
          ),
        ),
      ],
    );
  }
}

class _HelpCenterCard extends StatelessWidget {
  final _HelpCenter center;
  const _HelpCenterCard({required this.center});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceGlass,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.glassBorder, width: 1),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: center.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(center.icon, size: 22, color: center.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  center.name,
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  center.type,
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 11,
                    color: AppTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _MetaChip(
                      icon: Icons.directions_car_rounded,
                      label: center.distance,
                      color: center.color,
                    ),
                    const SizedBox(width: 8),
                    _MetaChip(
                      icon: Icons.timer_rounded,
                      label: 'ETA ${center.eta}',
                      color: AppTheme.warningAmber,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: center.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: center.color.withOpacity(0.35),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.call_rounded, size: 13, color: center.color),
                    const SizedBox(width: 4),
                    Text(
                      center.phone,
                      style: GoogleFonts.ibmPlexMono(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: center.color,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.safeGreen.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppTheme.safeGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Available',
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.safeGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MetaChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 11, color: color),
        const SizedBox(width: 3),
        Text(
          label,
          style: GoogleFonts.ibmPlexSans(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}
