import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListingSkeletonLoader extends StatefulWidget {
  const ListingSkeletonLoader({super.key});

  @override
  State<ListingSkeletonLoader> createState() => _ListingSkeletonLoaderState();
}

class _ListingSkeletonLoaderState extends State<ListingSkeletonLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(
      begin: -2,
      end: 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSkeletonCard(isDetailed: true),
          _buildSkeletonCard(isDetailed: false),
        ],
      ),
    );
  }

  Widget _buildSkeletonCard({bool isDetailed = true}) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  _buildShimmer(height: 40, width: 40, radius: 20), // Avatar
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildShimmer(height: 16, width: 120), // Name
                        const SizedBox(height: 4),
                        _buildShimmer(height: 14, width: 180), // Role
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildShimmer(height: 16, width: 200), // Type
              if (isDetailed) ...[
                const SizedBox(height: 12),
                _buildShimmer(height: 14, width: 100), // Budget
                const SizedBox(height: 8),
                _buildShimmer(height: 14, width: 150), // Brand
                const SizedBox(height: 8),
                _buildShimmer(height: 14, width: 140), // Location
                const SizedBox(height: 12),
                _buildShimmer(height: 60, width: double.infinity), // Description
                const SizedBox(height: 12),
                // Tags
                Row(
                  children: [
                    _buildShimmer(height: 24, width: 80, radius: 12),
                    const SizedBox(width: 8),
                    _buildShimmer(height: 24, width: 90, radius: 12),
                    const SizedBox(width: 8),
                    _buildShimmer(height: 24, width: 70, radius: 12),
                  ],
                ),
              ] else ...[
                const SizedBox(height: 12),
                _buildShimmer(height: 40, width: double.infinity), // Short description
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmer({
    required double height,
    required double width,
    double radius = 4,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(_animation.value, 0),
          end: const Alignment(1, 0),
          colors: const [
            Color(0xFFEEEEEE),
            Color(0xFFF5F5F5),
            Color(0xFFEEEEEE),
          ],
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
