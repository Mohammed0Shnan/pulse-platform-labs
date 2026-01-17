import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulsenow_flutter/core/constants/app_colors.dart';
import 'package:pulsenow_flutter/models/enums/sort_option_enums.dart';
import 'package:pulsenow_flutter/shared/widgets/ink_well_widget.dart';
import 'package:pulsenow_flutter/widgets/market_data_card_widget.dart';
import 'package:pulsenow_flutter/widgets/search_box-widget.dart';
import '../providers/market_data_provider.dart';
import '../models/market_data_model.dart';

class MarketDataScreen extends StatelessWidget {
  MarketDataScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get the MarketDataProvider instance
    MarketDataProvider marketDataProvider = context.read<MarketDataProvider>();

    return Consumer<MarketDataProvider>(
      builder: (context, provider, child) {
        final displayData = provider.filteredMarketData;

        return Column(
          children: [
            // Search Box Widget
            SearchBoxWidget(
              searchController: _searchController,
              onClearClick: () {
                _searchController.clear();
                marketDataProvider.clearSearch();
              },
              onSortClick: () => _showSortOptions(context),
            ),
            // Content
            Expanded(
              child: _buildContent(
                context,
                provider,
                displayData,
              ),
            ),
          ],
        );
      },
    );
  }

  // Show Sort Bottom Sheet
  void _showSortOptions(BuildContext context) {
    final provider = context.read<MarketDataProvider>();

    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           const  SizedBox(height: 24,),
            _buildSortOption(
              title: 'Sort by Symbol (A-Z)',
              option: SortOption.symbolAsc,
              selectedOption: provider.selectedSortOption,
              onTap: () {
                provider.sortBySymbol(ascending: true);
                Navigator.pop(context);
              },
            ),
            _buildSortOption(
              title: 'Sort by Symbol (Z-A)',
              option: SortOption.symbolDesc,
              selectedOption: provider.selectedSortOption,
              onTap: () {
                provider.sortBySymbol(ascending: false);
                Navigator.pop(context);
              },
            ),
            _buildSortOption(
              title: 'Sort by Price (Low-High)',
              option: SortOption.priceAsc,
              selectedOption: provider.selectedSortOption,
              onTap: () {
                provider.sortByPrice(ascending: true);
                Navigator.pop(context);
              },
            ),
            _buildSortOption(
              title: 'Sort by Price (High-Low)',
              option: SortOption.priceDesc,
              selectedOption: provider.selectedSortOption,
              onTap: () {
                provider.sortByPrice(ascending: false);
                Navigator.pop(context);
              },
            ),
            _buildSortOption(
              title: 'Sort by Change (High-Low)',
              option: SortOption.changeDesc,
              selectedOption: provider.selectedSortOption,
              onTap: () {
                provider.sortByChange(ascending: false);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Build Sort Bottom Sheet Option
  Widget _buildSortOption({
    required String title,
    required SortOption option,
    required SortOption? selectedOption,
    required VoidCallback onTap,
  }) {
    return InkWellWidget(
      onTap: onTap,
      child: ListTile(
        title: Text(title),
        trailing: Radio<SortOption>(
          value: option,
          groupValue: selectedOption,
          onChanged: (_) => onTap(),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    MarketDataProvider provider,
    List<MarketData> displayData,
  ) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(provider.error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: provider.loadMarketData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (displayData.isEmpty) {
      return Center(
        child: Text(
          provider.searchQuery.isNotEmpty
              ? 'No results found'
              : 'No market data available',
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _loadMarkedDate(context, force: true),
      child: ListView.builder(
        itemCount: displayData.length,
        itemBuilder: (_, index) => _buildMarketDataCard(displayData[index]),
      ),
    );
  }

  // Build Card
  Widget _buildMarketDataCard(MarketData data) {
    return MarketDataCard(
      data: data,
    );
  }

  // Call Get Marked Date Api
  Future<void> _loadMarkedDate(BuildContext context, {bool force = false}) {
    return context.read<MarketDataProvider>().loadMarketData(force: force);
  }
}
