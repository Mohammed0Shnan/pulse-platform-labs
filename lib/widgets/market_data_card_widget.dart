import 'package:flutter/material.dart';
import 'package:pulsenow_flutter/core/constants/app_colors.dart';
import 'package:pulsenow_flutter/core/helpers/numbers_helper.dart';
import 'package:pulsenow_flutter/models/market_data_model.dart';

class MarketDataCard extends StatelessWidget {
  final MarketData data;

  const MarketDataCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {

    final Color changeColor = _getColor();
    final IconData arrowIcon =  _getArrow();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        child: Row(
          children: [
            // Symbol and price - left side
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.symbol,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    NumberHelper.priceFormatter(data.price),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            // Change info with arrow - right side
            Row(
              children: [
                // Arrow
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: data.changePercent24h >= 0
                        ? AppColors.priceUp.withAlpha(50)
                        : AppColors.priceDown.withAlpha(50),

                  ),
                  child: Icon(
                    arrowIcon,
                    color: changeColor,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      NumberHelper.percentageFormatter(data.changePercent24h),
                      style: TextStyle(
                        color: changeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      NumberHelper.priceFormatter(data.change24h),
                      style: TextStyle(
                        color: changeColor.withOpacity(0.85),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor() {
    return data.changePercent24h >= 0 ? AppColors.priceUp : AppColors.priceDown;
  }
 IconData _getArrow(){
  return  data.changePercent24h >= 0 ? Icons.arrow_upward : Icons.arrow_downward;
  }

}
