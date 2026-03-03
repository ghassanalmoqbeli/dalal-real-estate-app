import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// API Service specifically for the local AI model connection.
///
/// IMPORTANT FOR LOCAL DEVELOPMENT:
/// - When running on an Android emulator, use "10.0.2.2" instead of "127.0.0.1"
/// - When running on a real Android device, use your laptop's local IP address
///   (e.g., "192.168.1.100") - both devices must be on the same WiFi network
/// - When running on iOS simulator, use "127.0.0.1" or "localhost"
/// - When running on a real iOS device, use your laptop's local IP address
class AiApiService {
  /// The base URL for the local AI prediction server.
  ///
  /// HOW TO GET YOUR LAPTOP'S IP:
  /// 1. Open Command Prompt (cmd)
  /// 2. Type: ipconfig
  /// 3. Look for "IPv4 Address" under your active network adapter (WiFi or Ethernet)
  /// 4. Replace the IP below with your laptop's IP
  ///
  /// Example: If your laptop IP is 192.168.1.100, set:
  /// static const String _baseUrl = 'http://192.168.1.100:8000';

  // For real Android device on same WiFi - use your laptop's IP
  // static const String _baseUrl = 'http://YOUR_LAPTOP_IP:8000';

  // For Android Emulator:
  // static const String _baseUrl = 'http://10.0.2.2:8000';

  // Default - will be overridden based on platform
  String get baseUrl {
    // For real device testing, you'll need to set your actual IP here
    // This is a placeholder - replace with your laptop's IP
    const String laptopIp = '192.168.1.9';
    if (kIsWeb) {
      return 'http://127.0.0.1:8000';
    }
    // For real devices (both Android and iOS), use the laptop's IP
    return 'http://$laptopIp:8000';
  }

  final Duration _timeout = const Duration(seconds: 30);

  /// Makes a POST request to the AI prediction endpoint.
  ///
  /// Throws:
  /// - [SocketException] when there's no network connection
  /// - [HttpException] when the server returns a non-200 status
  /// - [FormatException] when the response is not valid JSON
  Future<Map<String, dynamic>> predictPrice({
    required Map<String, dynamic> requestBody,
  }) async {
    final url = Uri.parse('$baseUrl/predict');

    debugPrint('🤖 AI API Request URL: $url');
    debugPrint('🤖 AI API Request Body: ${jsonEncode(requestBody)}');

    try {
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(requestBody),
          )
          .timeout(_timeout);

      debugPrint('🤖 AI API Response Status: ${response.statusCode}');
      debugPrint('🤖 AI API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw HttpException(
          'AI Server Error: Status ${response.statusCode} - ${response.body}',
        );
      }
    } on SocketException catch (e) {
      debugPrint('🤖 AI API Socket Error: $e');
      rethrow;
    } on http.ClientException catch (e) {
      debugPrint('🤖 AI API Client Error: $e');
      throw SocketException('Connection failed: ${e.message}');
    } on FormatException catch (e) {
      debugPrint('🤖 AI API Format Error: $e');
      rethrow;
    }
  }

  /// Test the connection to the AI server
  Future<bool> testConnection() async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 5));
      // Even if we get 404, it means the server is running
      return response.statusCode == 200 || response.statusCode == 404;
    } catch (e) {
      debugPrint('🤖 AI Server connection test failed: $e');
      return false;
    }
  }
}
