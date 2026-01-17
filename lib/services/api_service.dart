import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  static const String baseUrl = AppConstants.baseUrl;

  /// Fetches market data from the API
  /// Returns a list of market data as JSON maps
  Future<List<Map<String, dynamic>>> getMarketData() async {
    try {
      final uri = Uri.parse('$baseUrl${AppConstants.marketDataEndpoint}');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Validate response structure
        if (jsonData['success'] == true && jsonData['data'] != null) {
          return List<Map<String, dynamic>>.from(jsonData['data']);
        } else {
          throw Exception('Invalid response format from server');
        }
      } else {
        throw Exception('Failed to load market data: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// Fetches portfolio summary from the API
  /// Returns portfolio data as JSON map
  Future<Map<String, dynamic>> getPortfolioSummary() async {
    try {
      final uri = Uri.parse('$baseUrl${AppConstants.portfolioEndpoint}');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Validate response structure
        if (jsonData['success'] == true && jsonData['data'] != null) {
          return jsonData['data'];
        } else {
          throw Exception('Invalid response format from server');
        }
      } else {
        throw Exception('Failed to load portfolio: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }


}