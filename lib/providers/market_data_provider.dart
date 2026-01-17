import 'package:flutter/foundation.dart';
import 'package:pulsenow_flutter/models/enums/sort_option_enums.dart';
import 'package:pulsenow_flutter/services/websocket_service.dart';
import '../services/api_service.dart';
import '../models/market_data_model.dart';

class MarketDataProvider with ChangeNotifier {
  final ApiService _apiService;
  final WebSocketService _webSocketService = WebSocketService();

  MarketDataProvider(this._apiService) {
    loadMarketData();
  }

  List<MarketData> _marketData = [];
  bool _isLoading = false;
  String? _error;
  bool _hasLoaded = false;

  String _searchQuery = '';
  SortOption? _selectedSortOption;

  List<MarketData> get marketData => _marketData;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  SortOption? get selectedSortOption => _selectedSortOption;

  /// Filtered market data
  List<MarketData> get filteredMarketData {
    if (_searchQuery.isEmpty) return _marketData;
    return searchMarketData(_searchQuery);
  }

  /// REST API LOAD
  Future<void> loadMarketData({bool force = false}) async {
    if (_hasLoaded && !force) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _apiService.getMarketData();
      _marketData = data.map((json) => MarketData.fromJson(json)).toList();
      _hasLoaded = true;

      _connectWebSocket();
    } catch (e) {
      _error = e.toString();
      _marketData = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// WEBSOCKET HANDLING
  void _connectWebSocket() {
    if (_webSocketService.isConnected) return;

    _webSocketService.connect();

    _webSocketService.stream?.listen((event) {
      try {
        final symbol = event['symbol'];
        if (symbol == null) return;

        final index =
        _marketData.indexWhere((item) => item.symbol == symbol);

        if (index == -1) return;

        final updated = _marketData[index].copyWith(
          price: (event['price'] as num?)?.toDouble(),
          change24h: (event['change24h'] as num?)?.toDouble(),
          changePercent24h:
          (event['changePercent24h'] as num?)?.toDouble(),
        );

        _marketData[index] = updated;
        notifyListeners();
      } catch (e) {
        debugPrint('WebSocket update error: $e');
      }
    });
  }

  /// SEARCH
  List<MarketData> searchMarketData(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _marketData.where((data) {
      return data.symbol.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  /// SORTING
  void sortBySymbol({bool ascending = true}) {
    _marketData.sort((a, b) =>
    ascending ? a.symbol.compareTo(b.symbol) : b.symbol.compareTo(a.symbol));
    _selectedSortOption =
    ascending ? SortOption.symbolAsc : SortOption.symbolDesc;
    notifyListeners();
  }

  void sortByPrice({bool ascending = true}) {
    _marketData.sort((a, b) =>
    ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
    _selectedSortOption =
    ascending ? SortOption.priceAsc : SortOption.priceDesc;
    notifyListeners();
  }

  void sortByChange({bool ascending = true}) {
    _marketData.sort((a, b) => ascending
        ? a.changePercent24h.compareTo(b.changePercent24h)
        : b.changePercent24h.compareTo(a.changePercent24h));
    _selectedSortOption =
    ascending ? null : SortOption.changeDesc;
    notifyListeners();
  }

  /// CLEANUP
  @override
  void dispose() {
    _webSocketService.dispose();
    super.dispose();
  }
}
