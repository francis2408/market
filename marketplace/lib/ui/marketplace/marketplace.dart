import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketplace/common/theme/app_colors.dart';
import 'package:marketplace/common/widgets/loading_skeleton/market_skeleton.dart';
import 'package:marketplace/core/constants/app_assets.dart';
import 'package:marketplace/model/marketplace_model/marketplace_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:marketplace/repository/marketplace_repository/marketplace_repositories.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'marketplace_details.dart';

class Marketplace extends StatefulWidget {
  const Marketplace({super.key});

  @override
  State<Marketplace> createState() => _MarketplaceState();
}

class _MarketplaceState extends State<Marketplace> {
  static const _pageSize = 1;
  final PagingController<int, MarketplaceRequest> _pagingController = PagingController(firstPageKey: 1);

  final MarketplaceRepositories marketplaceRepositories = MarketplaceRepositories();
  MarketModel marketModel = MarketModel();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      getMarketList(pageKey);
    });
  }

  getMarketList(int page) async {
    try {
      MarketModel response = await marketplaceRepositories.getMarketList(page: page.toString());
      List<MarketplaceRequest> productsList = response.marketplaceRequests ?? [];
      final isLastPage = productsList.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(productsList);
      } else {
        final nextPageKey = page + 1;
        _pagingController.appendPage(productsList, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Marketplace',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              AppAssets.menu,
              height: 15,
              width: 15,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type your requirement here...',
                hintStyle: const TextStyle(
                  color: Colors.grey
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage(AppAssets.searchProfile),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterChip('For You', false),
                _buildFilterChip('Recent', true),
                _buildFilterChip('My Requests', false),
                _buildFilterChip('⭐ Top Rated', false),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: PagedListView<int, MarketplaceRequest>(
                pagingController: _pagingController,
                physics: const BouncingScrollPhysics(),
                builderDelegate: PagedChildBuilderDelegate<MarketplaceRequest>(
                  animateTransitions: true,
                  noItemsFoundIndicatorBuilder: (context) {
                    return const Center(child: Text("No data found."));
                  },
                  firstPageErrorIndicatorBuilder: (context) {
                    return const Center(child: Text("Error loading data"));
                  },
                  firstPageProgressIndicatorBuilder: (context) {
                    return Column(
                      children: List.generate(10, (index) => const ListingSkeletonLoader()),
                    );
                  },
                  newPageProgressIndicatorBuilder: (context) {
                    return const Skeletonizer(
                      child: ListingSkeletonLoader(),
                    );
                  },
                  itemBuilder: (context, item, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 10,),
                        _buildListingCard(
                            name: item.userDetails!.name ?? '',
                            role: "${item.userDetails!.designation ?? ''} at ${ item.userDetails!.company ?? ''}",
                            image: item.userDetails!.profileImage ?? '',
                            type: item.serviceType != '' ? "Looking for ${item.serviceType!}" : '',
                            description: item.description ?? '',
                            location: item.requestDetails != null ? item.requestDetails!.cities : [""],
                            tags: item.requestDetails != null ? item.requestDetails!.cities : [],
                            highValue: item.isHighValue ?? false,
                            isExpire: item.isHighValue == false ? item.createdAt != '' ? true : false : false,
                            instaFrom: item.requestDetails != null ? item.requestDetails!.followersRange != null ? item.requestDetails!.followersRange!.igFollowersMin : '' : '',
                            instaTo: item.requestDetails != null ? item.requestDetails!.followersRange != null ? item.requestDetails!.followersRange!.igFollowersMin : '' : '',
                            linkFrom: item.requestDetails != null ? item.requestDetails!.followersRange != null ? item.requestDetails!.followersRange!.ytSubscribersMin : '' : '',
                            linkTo: item.requestDetails != null ? item.requestDetails!.followersRange != null ? item.requestDetails!.followersRange!.ytSubscribersMin : '' : '',
                            onChange: () {
                              Navigator.pushNamed(context, '/marketDetail', arguments: MarketplaceDetails(idHash: item.idHash));
                            }
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 130,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.primaryColor,
        ),
        child: const Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            SizedBox(width: 5),
            Text(
              'Post Request',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        selected: isSelected,
        onSelected: (bool value) {},
        backgroundColor: Colors.white,
        selectedColor: Colors.red.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.red : Colors.grey[300]!,
          ),
        ),
      ),
    );
  }

  Widget _buildListingCard({
    required String name,
    required String image,
    required String role,
    required String type,
    List<String>? location,
    required String description,
    List<String>? tags,
    required bool highValue,
    bool isExpire = false,
    String? instaFrom,
    String? instaTo,
    String? linkFrom,
    String? linkTo,
    required VoidCallback onChange,
  }) {
    // Check if location list is null, empty, or contains only empty strings
    bool hasValidLocation = location != null &&
        location.isNotEmpty &&
        location.any((loc) => loc.trim().isNotEmpty);

    // Check if Instagram values are valid
    bool hasValidInsta = instaFrom != null &&
        instaTo != null &&
        instaFrom.trim().isNotEmpty &&
        instaTo.trim().isNotEmpty;

    // Check if YouTube values are valid
    bool hasValidYoutube = linkFrom != null &&
        linkTo != null &&
        linkFrom.trim().isNotEmpty &&
        linkTo.trim().isNotEmpty;

    return Container(
      clipBehavior: Clip.none,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: onChange,
            child: Card(
              elevation: 0,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey[300]!),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(image),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                role,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      type,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    Text(description),
                    const SizedBox(height: 12),
                    if (hasValidLocation) Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Color(0xFF666666),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Row(
                              children: [
                                ...List.generate(
                                  location!.length > 2 ? 2 : location.length,
                                      (index) => Flexible(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          location[index],
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF666666),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        if (index < (location.length > 2 ? 1 : location.length - 1))
                                          const Text(
                                            ', ',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF666666),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (location.length > 2)
                                  Text(
                                    ' +${location.length - 2}more',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF666666),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (hasValidInsta) Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppAssets.insta, height: 16),
                              const SizedBox(width: 10),
                              Text("$instaFrom - $instaTo"),
                            ],
                          ),
                        ),
                        if (hasValidInsta && hasValidYoutube)
                          const SizedBox(width: 8),
                        if (hasValidYoutube) Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppAssets.youtube, height: 16),
                              const SizedBox(width: 10),
                              Text("$linkFrom - $linkTo"),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          if (highValue)
            Positioned(
              top: -10,
              right: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.highValue,
                      height: 15,
                      width: 15,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'HIGH VALUE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (isExpire)
            Positioned(
              top: -10,
              right: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.bell,
                      height: 15,
                      width: 15,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'EXPIRING SOON',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
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
}
