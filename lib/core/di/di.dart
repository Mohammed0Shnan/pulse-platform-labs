import 'package:provider/provider.dart';
import 'package:pulsenow_flutter/providers/market_data_provider.dart';
import 'package:pulsenow_flutter/services/api_service.dart';
import 'package:provider/single_child_widget.dart';
class DI {
  static List<SingleChildWidget> getProviders() {
    final apiService = ApiService();

    return [
      ChangeNotifierProvider<MarketDataProvider>(
        create: (_) => MarketDataProvider( apiService,),
         lazy: true,
      ),
    ];
  }
}