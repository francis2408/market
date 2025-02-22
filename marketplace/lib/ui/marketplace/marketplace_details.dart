import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketplace/common/theme/app_colors.dart';
import 'package:marketplace/core/constants/app_assets.dart';

import '../../model/marketplace_model/marketplace_model.dart';
import '../../repository/marketplace_repository/marketplace_repositories.dart';

class MarketplaceDetails extends StatefulWidget {
  final String? idHash;

  const MarketplaceDetails({
    super.key,
    this.idHash,
  });

  @override
  State<MarketplaceDetails> createState() => _MarketplaceDetailsState();
}

class _MarketplaceDetailsState extends State<MarketplaceDetails> {
  MarketModel? marketDetails;
  bool isLoading = true;
  String? error;
  final MarketplaceRepositories marketplaceRepositories = MarketplaceRepositories();

  @override
  void initState() {
    super.initState();
    _loadMarketDetails();
  }

  Future<void> _loadMarketDetails() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final details = await marketplaceRepositories.getMarketDetail(
        idValue: widget.idHash,
      );

      setState(() {
        marketDetails = details;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              ElevatedButton(
                onPressed: _loadMarketDetails,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final details = marketDetails?.marketplaceRequests?.first;
    if (details == null) {
      return const Scaffold(
        body: Center(
          child: Text('No details found'),
        ),
      );
    }

    final userDetails = details.userDetails;
    final requestDetails = details.requestDetails;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          SvgPicture.asset(
            AppAssets.delete,
            height: 20,
            width: 20,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 10,),
          SvgPicture.asset(
            AppAssets.share,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 10,),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey.shade100,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(userDetails?.profileImage ?? ''),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            userDetails?.name ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        userDetails?.designation ?? '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        userDetails?.company ?? '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Looking for',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.stars, color: Colors.red),
                      const SizedBox(width: 8),
                      Text(
                        details.serviceType ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Divider(),
                  const Text(
                    'Highlights',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildHighlight('Budget: ${requestDetails?.budget ?? "N/A"}'),
                      const SizedBox(width: 12),
                      _buildHighlight('Brand: ${requestDetails?.brand ?? "N/A"}'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      details.description ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),

                  _buildShareButtons(),

                  const SizedBox(height: 24),
                  const Text(
                    'Key Highlighted Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildKeyDetailsGrid(details),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(details),
    );
  }

  Widget _buildKeyDetailsGrid(MarketplaceRequest details) {
    final requestDetails = details.requestDetails;
    final followersRange = requestDetails?.followersRange;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildKeyDetailItem('Category', (requestDetails?.categories ?? []).join(", ")),
        _buildKeyDetailItem('Platform', (requestDetails?.platform ?? []).join(", ")),
        _buildKeyDetailItem('Language', (requestDetails?.languages ?? []).join(", ")),
        _buildKeyDetailItem('Location', details.isPanIndia == true ? 'Pan India' : (requestDetails?.cities ?? []).join(", ")),
        _buildKeyDetailItem('Required count', '${requestDetails?.creatorCountMin ?? 0} - ${requestDetails?.creatorCountMax ?? 0}'),
        _buildKeyDetailItem('Our Budget', '₹${requestDetails?.budget ?? "N/A"}'),
        _buildKeyDetailItem('Brand collab with', requestDetails?.brand ?? 'N/A'),
        _buildKeyDetailItem('Required followers',
            'IG: ${followersRange?.igFollowersMin ?? 0} - ${followersRange?.igFollowersMax ?? 0}\n'
                'YT: ${followersRange?.ytSubscribersMin ?? 0} - ${followersRange?.ytSubscribersMax ?? 0}'),
      ],
    );
  }

  Widget _buildHighlight(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildShareButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green.withOpacity(0.1),
                ),
                child: Row(
                  children: [
                    Image.asset(AppAssets.whatsapp, height: 20, width: 20),
                    const SizedBox(width: 10,),
                    const Text(
                      "Share via WhatsApp",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue.withOpacity(0.1)
              ),
              child: Row(
                children: [
                  Image.asset(AppAssets.linkedin, height: 20, width: 20),
                  const SizedBox(width: 10,),
                  const Text(
                    "Share on LinkedIn",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKeyDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildBottomBar(MarketplaceRequest details) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(AppAssets.time, height: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Your post will expire on ${details.createdAt}',
                  style: const TextStyle(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildButton(
                  'Edit',
                  onTap: () {},
                  outlined: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildButton(
                  'Close',
                  onTap: () {},
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      String text, {
        required VoidCallback onTap,
        bool outlined = false,
        Color? color,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: outlined ? Border.all(color: AppColors.primaryColor) : null,
          color: outlined ? Colors.transparent : (color ?? AppColors.primaryColor),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: outlined ? AppColors.primaryColor : Colors.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}