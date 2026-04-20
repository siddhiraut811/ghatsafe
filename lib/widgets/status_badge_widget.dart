import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum SafetyStatus { safe, warning, danger, info, inactive }

class StatusBadgeWidget extends StatelessWidget {
  final SafetyStatus status;
  final String label;
  final bool compact;

  const StatusBadgeWidget({
    super.key,
    required this.status,
    required this.label,
    this.compact = false,
  });

  Color get _bgColor {
    switch (status) {
      case SafetyStatus.safe:
        return AppTheme.safeGreen.withAlpha(46);
      case SafetyStatus.warning:
        return AppTheme.warningAmber.withAlpha(46);
      case SafetyStatus.danger:
        return AppTheme.dangerRed.withAlpha(46);
      case SafetyStatus.info:
        return AppTheme.infoBlue.withAlpha(46);
      case SafetyStatus.inactive:
        return const Color(0x1AFFFFFF);
    }
  }

  Color get _textColor {
    switch (status) {
      case SafetyStatus.safe:
        return AppTheme.safeGreen;
      case SafetyStatus.warning:
        return AppTheme.warningAmber;
      case SafetyStatus.danger:
        return AppTheme.dangerRed;
      case SafetyStatus.info:
        return AppTheme.infoBlue;
      case SafetyStatus.inactive:
        return AppTheme.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _textColor.withAlpha(77), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _textColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: _textColor,
              fontSize: compact ? 10 : 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
