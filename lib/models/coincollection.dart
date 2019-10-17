import 'dart:convert';

class CoinCollection {
  List<Coin> coins;

  CoinCollection({
    this.coins,
  });

  factory CoinCollection.fromJson(Map<String, dynamic> json) => CoinCollection(
    coins: List<Coin>.from(json["data"].map((x) => Coin.fromJson(x))),
  );
}

class Coin {
  String id;
  String symbol;
  String name;
  String nameid;
  int rank;
  String priceUsd;
  String percentChange24H;
  String percentChange1H;
  String percentChange7D;
  String priceBtc;
  String marketCapUsd;
  double volume24;
  double volume24A;
  String csupply;
  String tsupply;
  String msupply;

  Coin({
    this.id,
    this.symbol,
    this.name,
    this.nameid,
    this.rank,
    this.priceUsd,
    this.percentChange24H,
    this.percentChange1H,
    this.percentChange7D,
    this.priceBtc,
    this.marketCapUsd,
    this.volume24,
    this.volume24A,
    this.csupply,
    this.tsupply,
    this.msupply,
  });

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
    id: json["id"],
    symbol: json["symbol"],
    name: json["name"],
    nameid: json["nameid"],
    rank: json["rank"],
    priceUsd: json["price_usd"],
    percentChange24H: json["percent_change_24h"],
    percentChange1H: json["percent_change_1h"],
    percentChange7D: json["percent_change_7d"],
    priceBtc: json["price_btc"],
    marketCapUsd: json["market_cap_usd"],
    volume24: json["volume24"].toDouble(),
    volume24A: json["volume24a"].toDouble(),
    csupply: json["csupply"],
    tsupply: json["tsupply"].toString(),
    msupply: json["msupply"],
  );
}
