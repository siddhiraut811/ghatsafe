import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../sos_screen.dart';

class SOSLocationWidget extends StatelessWidget {
  final SOSState sosState;

  const SOSLocationWidget({super.key, required this.sosState});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceGlass,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: sosState == SOSState.active
              ? AppTheme.dangerRed.withOpacity(0.4)
              : AppTheme.glassBorder,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.infoBlue.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  size: 18,
                  color: AppTheme.infoBlue,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your GPS Location',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    sosState == SOSState.active
                        ? 'Broadcasting to all centers'
                        : 'Will be shared on SOS activation',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 10,
                      color: sosState == SOSState.active
                          ? AppTheme.dangerRed
                          : AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.safeGreen.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
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
                      'GPS Lock',
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
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _CoordRow(label: 'Latitude', value: '18.7645° N'),
                ),
                Container(width: 1, height: 32, color: AppTheme.glassBorder),
                Expanded(
                  child: _CoordRow(
                    label: 'Longitude',
                    value: '73.4062° E',
                    centered: true,
                  ),
                ),
                Container(width: 1, height: 32, color: AppTheme.glassBorder),
                Expanded(
                  child: _CoordRow(
                    label: 'Accuracy',
                    value: '±4.2m',
                    isRight: true,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.place_rounded,
                size: 14,
                color: AppTheme.textMuted,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Near Km 34.2, Lonavala–Khandala Ghat, Maharashtra',
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 11,
                    color: AppTheme.textMuted,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CoordRow extends StatelessWidget {
  final String label;
  final String value;
  final bool centered;
  final bool isRight;

  const _CoordRow({
    required this.label,
    required this.value,
    this.centered = false,
    this.isRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: centered
            ? 12
            : isRight
            ? 12
            : 0,
        right: isRight
            ? 0
            : centered
            ? 12
            : 12,
      ),
      child: Column(
        crossAxisAlignment: centered
            ? CrossAxisAlignment.center
            : isRight
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.ibmPlexSans(
              fontSize: 9,
              color: AppTheme.textMuted,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.ibmPlexMono(
              fontSize: 12,
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
