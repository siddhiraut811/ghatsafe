import 'package:flutter/material.dart';
import '../presentation/sign_up_login_screen/sign_up_login_screen.dart';
import '../presentation/driver_dashboard_screen/driver_dashboard_screen.dart';
import '../presentation/sos_screen/sos_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String signUpLoginScreen = '/sign-up-login-screen';
  static const String driverDashboardScreen = '/driver-dashboard-screen';
  static const String sosScreen = '/sos-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SignUpLoginScreen(),
    signUpLoginScreen: (context) => const SignUpLoginScreen(),
    driverDashboardScreen: (context) => const DriverDashboardScreen(),
    sosScreen: (context) => const SOSScreen(),
  };
}
