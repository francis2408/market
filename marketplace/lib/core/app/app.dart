import 'package:flutter/material.dart';
import 'package:marketplace/common/helper/app_routes.dart';
import 'package:marketplace/common/theme/app_colors.dart';
import 'package:marketplace/core/constants/fonts.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(0.9)),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Marketplace',
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.splash,
      theme: ThemeData(
        fontFamily: AppFonts.inter,
        primaryColor: AppColors.primaryColor,
        secondaryHeaderColor: AppColors.textColor,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
    );
  }
}