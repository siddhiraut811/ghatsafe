import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import './widgets/active_alerts_widget.dart';
import './widgets/dashboard_app_bar_widget.dart';
import './widgets/kpi_chips_widget.dart';
import './widgets/road_conditions_widget.dart';
import './widgets/speed_gauge_widget.dart';

class DriverDashboardScreen extends StatefulWidget {
  const DriverDashboardScreen({super.key});

  @override
  State<DriverDashboardScreen> createState() => _DriverDashboardScreenState();
}

class _DriverDashboardScreenState extends State<DriverDashboardScreen>
    with TickerProviderStateMixin {
  final double _currentSpeed = 52.0;
  final int _speedLimit = 40;
  bool _isOverSpeed = false;
  final int _activeAlertCount = 3;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _isOverSpeed = _currentSpeed > _speedLimit;

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    if (_isOverSpeed) _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundDark,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: DashboardAppBarWidget(
            alertCount: _activeAlertCount,
            isOverSpeed: _isOverSpeed,
          ),
        ),
        body: SafeArea(
          child: isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
        ),
        floatingActionButton: _buildSOSFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpeedGaugeWidget(
            currentSpeed: _currentSpeed,
            speedLimit: _speedLimit,
            isOverSpeed: _isOverSpeed,
            pulseAnimation: _pulseAnimation,
          ),
          const SizedBox(height: 16),
          KpiChipsWidget(isOverSpeed: _isOverSpeed),
          const SizedBox(height: 20),
          _buildSectionHeader(
            'Active Alerts',
            Icons.warning_amber_rounded,
            AppTheme.warningAmber,
            '$_activeAlertCount active',
          ),
          const SizedBox(height: 10),
          const ActiveAlertsWidget(),
          const SizedBox(height: 20),
          _buildSectionHeader(
            'Road Conditions',
            Icons.terrain_rounded,
            AppTheme.infoBlue,
            'Live',
          ),
          const SizedBox(height: 10),
          const RoadConditionsWidget(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 100),
            child: Column(
              children: [
                SpeedGaugeWidget(
                  currentSpeed: _currentSpeed,
                  speedLimit: _speedLimit,
                  isOverSpeed: _isOverSpeed,
                  pulseAnimation: _pulseAnimation,
                ),
                const SizedBox(height: 16),
                KpiChipsWidget(isOverSpeed: _isOverSpeed),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader(
                  'Active Alerts',
                  Icons.warning_amber_rounded,
                  AppTheme.warningAmber,
                  '$_activeAlertCount active',
                ),
                const SizedBox(height: 10),
                const ActiveAlertsWidget(),
                const SizedBox(height: 20),
                _buildSectionHeader(
                  'Road Conditions',
                  Icons.terrain_rounded,
                  AppTheme.infoBlue,
                  'Live',
                ),
                const SizedBox(height: 10),
                const RoadConditionsWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    String title,
    IconData icon,
    Color color,
    String badge,
  ) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.ibmPlexSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: color.withAlpha(38),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            badge,
            style: GoogleFonts.ibmPlexSans(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSOSFab() {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: Container(
        height: 64,
        width: 180,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF3B30), Color(0xFFFF6B35)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppTheme.dangerRed.withAlpha(128),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(32),
            splashColor: Colors.white.withAlpha(51),
            onTap: () => Navigator.pushNamed(context, AppRoutes.sosScreen),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.sos_rounded, color: Colors.white, size: 24),
                const SizedBox(width: 10),
                Text(
                  'SOS Emergency',
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
