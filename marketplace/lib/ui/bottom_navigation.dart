import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketplace/common/theme/app_colors.dart';
import 'package:marketplace/core/constants/app_assets.dart';

import 'marketplace/marketplace.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with SingleTickerProviderStateMixin {
  int _currentIndex = 1;
  late AnimationController _controller;
  static const Duration _animationDuration = Duration(milliseconds: 300);

  final List<Widget> _pagesLoggedIn = [
    Container(),
    const Marketplace(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToPage(int index) {
    final fullScreenPages =[1, 2];

    if (fullScreenPages.contains(index)) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => _pagesLoggedIn[index],
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.easeOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ).then((_) {
        setState(() {
          _currentIndex = 0;
        });
      });
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final navItems = [
      _buildNavItem(0, AppAssets.explore, 'Explore'),
      _buildNavItem(1, AppAssets.group, 'Marketplace'),
      _buildNavItem(2, AppAssets.search, 'Search'),
      _buildNavItem(3, AppAssets.activity, 'Activity'),
      _buildNavItem(4, AppAssets.profile, 'Profile'),
    ];

    return Scaffold(
      body: _pagesLoggedIn[_currentIndex],
      bottomNavigationBar: AnimatedContainer(
        duration: _animationDuration,
        height: 70,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: navItems,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String icon, String label) {
    final isSelected = _currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          if (_currentIndex == 1) {
            _navigateToPage(index);
          }
        },
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / (3),
              height: 80,
              child: Center(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.only(top: 8),
                            child: SvgPicture.asset(
                              icon,
                              height: 20,
                              width: 20,
                              colorFilter: ColorFilter.mode(
                                isSelected ? AppColors.primaryColor : AppColors.shadowColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            label,
                            style: TextStyle(
                              color: isSelected ? AppColors.textColor : AppColors.shadowColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      if (isSelected) Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                            padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryColor,
                            ),
                            child: const Text(
                              'New',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

