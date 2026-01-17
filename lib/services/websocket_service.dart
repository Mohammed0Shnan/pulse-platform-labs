import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../utils/constants.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  Stream<Map<String, dynamic>>? get stream =>
      _channel?.stream.map((message) {
        return json.decode(message as String) as Map<String, dynamic>;
      });

  void connect() {
    if (_isConnected) return;

    try {
      final uri = Uri.parse(AppConstants.wsUrl);
      _channel = WebSocketChannel.connect(uri);
      _isConnected = true;
      print('WebSocket connected');
    } catch (e) {
      print('WebSocket connection failed: $e');
      _isConnected = false;
    }
  }

  void disconnect() {
    _isConnected = false;
    _channel?.sink.close();
    _channel = null;
    print('WebSocket disconnected');
  }

  void dispose() {
    disconnect();
  }
}
