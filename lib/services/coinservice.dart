
import 'dart:convert';

import 'package:flutter_app/models/coincollection.dart';
import 'package:http/http.dart' as http;

class CoinService {
  static Future<List<Coin>> getCoinList({int start = 0, int limit = 0}) async{
    final url = "https://api.coinlore.com/api/tickers/?start=${start.toString()}&limit=${limit.toString()}";

    final response = await http.get(url);

    if(response.statusCode == 200){
      final jsonResponse = json.decode(response.body);
      CoinCollection coinList = CoinCollection.fromJson(jsonResponse);
      return coinList.coins;
    }else{
      throw Exception("Fail to getTopCoinList status: ${response.statusCode}");
    }
  }
}