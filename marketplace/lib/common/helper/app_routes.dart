import 'package:flutter/cupertino.dart';
import 'package:marketplace/ui/bottom_navigation.dart';
import 'package:marketplace/ui/marketplace/marketplace.dart';
import 'package:marketplace/ui/marketplace/marketplace_details.dart';
import 'package:marketplace/ui/splash/splash_screen.dart';

class Routes {
  static const String splash = '/splash';
  static const String market = '/market';
  static const String marketDetail = '/marketDetail';
  static const String bottomNavigation = '/bottomNavigation';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _fadeAnimation(const SplashScreen());
      case bottomNavigation:
        return _fadeAnimation(const BottomNavigation());
      case market:
        return _fadeAnimation(const Marketplace());
      case marketDetail:
        return _fadeAnimation(const MarketplaceDetails());
      default:
        return _fadeAnimation(const Marketplace());
    }
  }

  static PageRouteBuilder _fadeAnimation(Widget child) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutBack,
            ),
          ),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.1, 0.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOutBack,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
