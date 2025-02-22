
import 'package:marketplace/model/marketplace_model/marketplace_model.dart';
import 'package:marketplace/service/marketplace_service/marketplace_service.dart';

class MarketplaceRepositories {
  final MarketplaceService marketplaceService = MarketplaceService();

  Future<MarketModel> getMarketList({String? page}) async {
    try {
      MarketModel marketModel = await marketplaceService.getMarketList(page: page);
      return marketModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<MarketModel> getMarketDetail({String? idValue}) async {
    try {
      MarketModel marketModel = await marketplaceService.getMarketDetail(idValue: idValue);
      return marketModel;
    } catch (e) {
      rethrow;
    }
  }
}
