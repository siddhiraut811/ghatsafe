import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import './widgets/sos_broadcast_status_widget.dart';
import './widgets/sos_help_centers_widget.dart';
import './widgets/sos_location_widget.dart';
import './widgets/sos_trigger_button_widget.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});

  @override
  State<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> with TickerProviderStateMixin {
  SOSState _sosState = SOSState.idle;
  int _countdown = 5;

  late AnimationController _rippleController;
  late AnimationController _countdownController;

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _countdownController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _countdownController.dispose();
    super.dispose();
  }

  void _onSOSTap() {
    if (_sosState == SOSState.idle) {
      setState(() => _sosState = SOSState.confirming);
      _startCountdown();
    }
  }

  void _startCountdown() async {
    for (int i = 5; i >= 0; i--) {
      if (!mounted) return;
      setState(() => _countdown = i);
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      if (_sosState == SOSState.cancelled) return;
    }
    if (!mounted) return;
    if (_sosState != SOSState.cancelled) {
      HapticFeedback.heavyImpact();
      setState(() => _sosState = SOSState.active);
    }
  }

  void _cancelSOS() {
    setState(() {
      _sosState = SOSState.cancelled;
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) setState(() => _sosState = SOSState.idle);
      });
    });
  }

  void _resetSOS() {
    setState(() {
      _sosState = SOSState.idle;
      _countdown = 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: _sosState == SOSState.active
            ? const Color(0xFF1A0000)
            : AppTheme.backgroundDark,
        body: SafeArea(
          child: isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
        ),
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  SOSTriggerButtonWidget(
                    sosState: _sosState,
                    countdown: _countdown,
                    rippleController: _rippleController,
                    onTap: _onSOSTap,
                    onCancel: _cancelSOS,
                    onReset: _resetSOS,
                  ),
                  const SizedBox(height: 20),
                  SOSLocationWidget(sosState: _sosState),
                  const SizedBox(height: 16),
                  if (_sosState == SOSState.active)
                    SOSBroadcastStatusWidget(
                      rippleController: _rippleController,
                    ),
                  if (_sosState == SOSState.active) const SizedBox(height: 16),
                  const SOSHelpCentersWidget(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SOSTriggerButtonWidget(
                        sosState: _sosState,
                        countdown: _countdown,
                        rippleController: _rippleController,
                        onTap: _onSOSTap,
                        onCancel: _cancelSOS,
                        onReset: _resetSOS,
                      ),
                      const SizedBox(height: 20),
                      SOSLocationWidget(sosState: _sosState),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      if (_sosState == SOSState.active) ...[
                        SOSBroadcastStatusWidget(
                          rippleController: _rippleController,
                        ),
                        const SizedBox(height: 16),
                      ],
                      const SOSHelpCentersWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.glassBorder, width: 1),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (_sosState == SOSState.active) {
                _showExitConfirmation();
              } else {
                Navigator.pop(context);
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.surfaceGlass,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.glassBorder, width: 1),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppTheme.textPrimary,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Emergency SOS',
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                _sosState == SOSState.active
                    ? 'SOS Active — Help is on the way'
                    : _sosState == SOSState.confirming
                    ? 'Activating in $_countdown seconds...'
                    : 'Tap SOS button to broadcast emergency',
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 11,
                  color: _sosState == SOSState.active
                      ? AppTheme.dangerRed
                      : AppTheme.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (_sosState == SOSState.idle)
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.driverDashboardScreen),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceGlass,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.glassBorder, width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.dashboard_rounded,
                      size: 14,
                      color: AppTheme.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Dashboard',
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 12,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Cancel SOS?',
          style: GoogleFonts.ibmPlexSans(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'SOS is currently active. Cancelling will stop the emergency broadcast to all help centers.',
          style: GoogleFonts.ibmPlexSans(
            color: AppTheme.textMuted,
            fontSize: 13,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Keep SOS Active',
              style: GoogleFonts.ibmPlexSans(
                color: AppTheme.safeGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _resetSOS();
              Navigator.pop(context);
            },
            child: Text(
              'Cancel SOS',
              style: GoogleFonts.ibmPlexSans(
                color: AppTheme.dangerRed,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum SOSState { idle, confirming, active, cancelled }
