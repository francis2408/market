import 'package:flutter/material.dart';
import 'package:marketplace/common/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, '/bottomNavigation');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1),
          child: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Market',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 52,
                    color: AppColors.primaryColor,
                  ),
                ),
                TextSpan(
                  text: 'place',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 52,
                    color: AppColors.textColor,
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
