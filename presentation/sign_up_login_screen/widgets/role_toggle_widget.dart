import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class RoleToggleWidget extends StatelessWidget {
  final bool isDriver;
  final ValueChanged<bool> onToggle;

  const RoleToggleWidget({
    super.key,
    required this.isDriver,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppTheme.surfaceGlass,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.glassBorder, width: 1),
      ),
      child: Row(
        children: [
          _RoleTab(
            label: 'Driver',
            icon: Icons.drive_eta_rounded,
            isSelected: isDriver,
            selectedColor: AppTheme.primaryWarning,
            onTap: () => onToggle(true),
          ),
          _RoleTab(
            label: 'Authority',
            icon: Icons.admin_panel_settings_rounded,
            isSelected: !isDriver,
            selectedColor: AppTheme.authorityBlue,
            onTap: () => onToggle(false),
          ),
        ],
      ),
    );
  }
}

class _RoleTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Color selectedColor;
  final VoidCallback onTap;

  const _RoleTab({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected
                ? selectedColor.withOpacity(0.18)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isSelected
                ? Border.all(color: selectedColor.withOpacity(0.4), width: 1)
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? selectedColor : AppTheme.textMuted,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? selectedColor : AppTheme.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
