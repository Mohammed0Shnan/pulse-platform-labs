import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulsenow_flutter/providers/market_data_provider.dart';

class SearchBoxWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function() onSortClick;
  final Function() onClearClick;
  const SearchBoxWidget({
    super.key,
    required this.searchController,
    required this.onSortClick,
    required this.onClearClick,
  });

  @override
  Widget build(BuildContext context) {
    MarketDataProvider provider = context.read<MarketDataProvider>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search crypto...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: provider.searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed:onClearClick ,
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: provider.setSearchQuery,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: onSortClick,
          ),
        ],
      ),
    );
  }
}
