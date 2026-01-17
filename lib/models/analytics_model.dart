
class AnalyticsOverview {
  final double totalMarketCap;
  final double totalVolume24h;
  final int activeMarkets;
  final MarketLeader topGainer;
  final MarketLeader topLoser;

  AnalyticsOverview({
    required this.totalMarketCap,
    required this.totalVolume24h,
    required this.activeMarkets,
    required this.topGainer,
    required this.topLoser,
  });

  factory AnalyticsOverview.fromJson(Map<String, dynamic> json) {
    return AnalyticsOverview(
      totalMarketCap: (json['totalMarketCap'] as num).toDouble(),
      totalVolume24h: (json['totalVolume24h'] as num).toDouble(),
      activeMarkets: json['activeMarkets'] as int,
      topGainer: MarketLeader.fromJson(json['topGainer'] as Map<String, dynamic>),
      topLoser: MarketLeader.fromJson(json['topLoser'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalMarketCap': totalMarketCap,
      'totalVolume24h': totalVolume24h,
      'activeMarkets': activeMarkets,
      'topGainer': topGainer.toJson(),
      'topLoser': topLoser.toJson(),
    };
  }
}

class MarketLeader {
  final String symbol;
  final double changePercent;
  final double price;

  MarketLeader({
    required this.symbol,
    required this.changePercent,
    required this.price,
  });

  factory MarketLeader.fromJson(Map<String, dynamic> json) {
    return MarketLeader(
      symbol: json['symbol'] as String,
      changePercent: (json['changePercent'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'changePercent': changePercent,
      'price': price,
    };
  }

  bool get isGainer => changePercent > 0;
}
