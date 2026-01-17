
class PortfolioSummary {
  final double totalValue;
  final double totalPnl;
  final double totalPnlPercent;
  final int totalHoldings;
  final DateTime lastUpdated;

  PortfolioSummary({
    required this.totalValue,
    required this.totalPnl,
    required this.totalPnlPercent,
    required this.totalHoldings,
    required this.lastUpdated,
  });

  factory PortfolioSummary.fromJson(Map<String, dynamic> json) {
    return PortfolioSummary(
      totalValue: double.parse(json['totalValue'] as String),
      totalPnl: double.parse(json['totalPnl'] as String),
      totalPnlPercent: double.parse(json['totalPnlPercent'] as String),
      totalHoldings: json['totalHoldings'] as int,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalValue': totalValue.toString(),
      'totalPnl': totalPnl.toString(),
      'totalPnlPercent': totalPnlPercent.toString(),
      'totalHoldings': totalHoldings,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class PortfolioHolding {
  final String id;
  final String symbol;
  final double quantity;
  final double averagePrice;
  final double currentPrice;
  final double pnl;
  final double pnlPercent;

  PortfolioHolding({
    required this.id,
    required this.symbol,
    required this.quantity,
    required this.averagePrice,
    required this.currentPrice,
    required this.pnl,
    required this.pnlPercent,
  });

  factory PortfolioHolding.fromJson(Map<String, dynamic> json) {
    return PortfolioHolding(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      averagePrice: (json['averagePrice'] as num).toDouble(),
      currentPrice: (json['currentPrice'] as num).toDouble(),
      pnl: (json['pnl'] as num).toDouble(),
      pnlPercent: (json['pnlPercent'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'quantity': quantity,
      'averagePrice': averagePrice,
      'currentPrice': currentPrice,
      'pnl': pnl,
      'pnlPercent': pnlPercent,
    };
  }
  /// Example
  // Computed properties
  double get totalValue => quantity * currentPrice;
}

class Transaction {
  final String id;
  final String symbol;
  final String type;
  final double quantity;
  final double price;
  final DateTime timestamp;

  Transaction({
    required this.id,
    required this.symbol,
    required this.type,
    required this.quantity,
    required this.price,
    required this.timestamp,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      type: json['type'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'type': type,
      'quantity': quantity,
      'price': price,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}