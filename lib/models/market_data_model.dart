class MarketData {
  final String symbol;
  final double price;
  final double change24h;
  final double changePercent24h;
  final double volume;

  MarketData({
    required this.symbol,
    required this.price,
    required this.change24h,
    required this.changePercent24h,
    required this.volume,
  });

  factory MarketData.fromJson(Map<String, dynamic> json) {
    return MarketData(
      symbol: json['symbol'] as String,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      change24h: (json['change24h'] as num?)?.toDouble() ?? 0.0,
      changePercent24h:
      (json['changePercent24h'] as num?)?.toDouble() ?? 0.0,
      volume: (json['volume'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// Used for WebSocket real-time updates
  MarketData copyWith({
    double? price,
    double? change24h,
    double? changePercent24h,
    double? volume,
  }) {
    return MarketData(
      symbol: symbol,
      price: price ?? this.price,
      change24h: change24h ?? this.change24h,
      changePercent24h:
      changePercent24h ?? this.changePercent24h,
      volume: volume ?? this.volume,
    );
  }
}
