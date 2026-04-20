import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class CredentialsHintWidget extends StatelessWidget {
  final bool isDriver;
  final String driverEmail;
  final String driverPassword;
  final String authorityEmail;
  final String authorityPassword;
  final void Function(String email, String password) onAutofill;

  const CredentialsHintWidget({
    super.key,
    required this.isDriver,
    required this.driverEmail,
    required this.driverPassword,
    required this.authorityEmail,
    required this.authorityPassword,
    required this.onAutofill,
  });

  @override
  Widget build(BuildContext context) {
    final email = isDriver ? driverEmail : authorityEmail;
    final password = isDriver ? driverPassword : authorityPassword;
    final accentColor = isDriver
        ? AppTheme.primaryWarning
        : AppTheme.authorityBlue;
    final roleLabel = isDriver ? 'Driver Demo' : 'Authority Demo';

    return Container(
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accentColor.withOpacity(0.2), width: 1),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded, size: 14, color: accentColor),
              const SizedBox(width: 6),
              Text(
                '$roleLabel Credentials',
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _CredentialRow(
            label: 'Email',
            value: email,
            accentColor: accentColor,
          ),
          const SizedBox(height: 6),
          _CredentialRow(
            label: 'Password',
            value: password,
            accentColor: accentColor,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: OutlinedButton.icon(
              onPressed: () => onAutofill(email, password),
              icon: Icon(
                Icons.auto_fix_high_rounded,
                size: 14,
                color: accentColor,
              ),
              label: Text(
                'Use These Credentials',
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: accentColor.withOpacity(0.4), width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CredentialRow extends StatelessWidget {
  final String label;
  final String value;
  final Color accentColor;

  const _CredentialRow({
    required this.label,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 64,
          child: Text(
            label,
            style: GoogleFonts.ibmPlexSans(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppTheme.textMuted,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.ibmPlexMono(
              fontSize: 11,
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: value));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '$label copied',
                  style: GoogleFonts.ibmPlexSans(fontSize: 12),
                ),
                duration: const Duration(seconds: 1),
                backgroundColor: accentColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.all(16),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            child: Icon(Icons.copy_rounded, size: 14, color: accentColor),
          ),
        ),
      ],
    );
  }
}
