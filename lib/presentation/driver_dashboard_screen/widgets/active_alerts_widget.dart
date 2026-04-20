import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/status_badge_widget.dart';

class _AlertData {
  final String id;
  final String type;
  final String description;
  final String distance;
  final String time;
  final SafetyStatus severity;
  final IconData icon;

  const _AlertData({
    required this.id,
    required this.type,
    required this.description,
    required this.distance,
    required this.time,
    required this.severity,
    required this.icon,
  });
}

class ActiveAlertsWidget extends StatefulWidget {
  const ActiveAlertsWidget({super.key});

  @override
  State<ActiveAlertsWidget> createState() => _ActiveAlertsWidgetState();
}

class _ActiveAlertsWidgetState extends State<ActiveAlertsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _staggerController;

  final List<_AlertData> _alerts = const [
    _AlertData(
      id: 'ALT-001',
      type: 'Sharp Curve',
      description: 'Hairpin bend ahead — reduce speed to 20 km/h',
      distance: '1.1 km',
      time: '2 min',
      severity: SafetyStatus.danger,
      icon: Icons.turn_sharp_right_rounded,
    ),
    _AlertData(
      id: 'ALT-002',
      type: 'Vehicle Ahead',
      description: 'Heavy truck detected — 80m ahead, moving slowly',
      distance: '80 m',
      time: 'Now',
      severity: SafetyStatus.warning,
      icon: Icons.local_shipping_rounded,
    ),
    _AlertData(
      id: 'ALT-003',
      type: 'Road Damage',
      description: 'Pothole cluster reported at Km 34.2 — drive carefully',
      distance: '2.4 km',
      time: '4 min',
      severity: SafetyStatus.warning,
      icon: Icons.report_problem_rounded,
    ),
    _AlertData(
      id: 'ALT-004',
      type: 'Fog Zone',
      description: 'Low visibility zone — fog lights recommended',
      distance: '3.8 km',
      time: '6 min',
      severity: SafetyStatus.info,
      icon: Icons.help_outline,
    ),
    _AlertData(
      id: 'ALT-005',
      type: 'Speed Zone',
      description: 'School zone ahead — speed limit drops to 25 km/h',
      distance: '5.0 km',
      time: '8 min',
      severity: SafetyStatus.info,
      icon: Icons.school_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_alerts.length, (i) {
        final delay = (i * 0.15).clamp(0.0, 0.9);
        final animation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _staggerController,
            curve: Interval(
              delay,
              (delay + 0.4).clamp(0.0, 1.0),
              curve: Curves.easeOutCubic,
            ),
          ),
        );
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.04, 0),
              end: Offset.zero,
            ).animate(animation),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _AlertItem(alert: _alerts[i]),
            ),
          ),
        );
      }),
    );
  }
}

class _AlertItem extends StatelessWidget {
  final _AlertData alert;
  const _AlertItem({required this.alert});

  Color get _borderColor {
    switch (alert.severity) {
      case SafetyStatus.danger:
        return AppTheme.dangerRed.withAlpha(102);
      case SafetyStatus.warning:
        return AppTheme.warningAmber.withAlpha(77);
      default:
        return AppTheme.glassBorder;
    }
  }

  Color get _leftBorderColor {
    switch (alert.severity) {
      case SafetyStatus.danger:
        return AppTheme.dangerRed;
      case SafetyStatus.warning:
        return AppTheme.warningAmber;
      case SafetyStatus.info:
        return AppTheme.infoBlue;
      default:
        return AppTheme.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceGlass,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor, width: 1),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: _leftBorderColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _leftBorderColor.withAlpha(31),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        alert.icon,
                        size: 20,
                        color: _leftBorderColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                alert.type,
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              StatusBadgeWidget(
                                status: alert.severity,
                                label: alert.severity.name.toUpperCase(),
                                compact: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            alert.description,
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 11,
                              color: AppTheme.textMuted,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          alert.distance,
                          style: GoogleFonts.ibmPlexMono(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: _leftBorderColor,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                        Text(
                          alert.time,
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: 10,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
