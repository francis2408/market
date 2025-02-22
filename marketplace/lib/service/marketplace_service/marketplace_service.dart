import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marketplace/core/network/dio_client.dart';
import 'package:marketplace/model/marketplace_model/marketplace_model.dart';

class MarketplaceService {
  final Dio _dio = ApiClient.dio;

  Future<MarketModel> getMarketList({String? page}) async {
    try {
      var queryParameters = {
        'page': page,
      };
      var response = await _dio.get("/interview.mplist", queryParameters: queryParameters);
      if (response.statusCode == 200) {
        MarketModel marketModel = MarketModel.fromJson(response.data);
        return marketModel;
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong");
      rethrow;
    }
  }

  Future<MarketModel> getMarketDetail({String? idValue}) async {
    try {
      var queryParameters = {
        'id_hash': idValue,
      };
      var response = await _dio.get("/interview.mplist", queryParameters: queryParameters);
      if (response.statusCode == 200) {
        MarketModel marketModel = MarketModel.fromJson(response.data);
        return marketModel;
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong");
      rethrow;
    }
  }
}