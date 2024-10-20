import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Stream<List<String>> fetchQrCodesStream() async* {
  while (true) {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:5000/list_qr_codes'));

      if (response.statusCode == 200) {
        List<String> qrCodes = List<String>.from(json.decode(response.body));
        yield qrCodes; // Emit the list of QR codes
      } else {
        throw Exception('Failed to load QR codes');
      }
    } catch (e) {
      // Handle errors
      if (kDebugMode) {
        print('Error fetching QR codes: $e');
      }
      yield []; // Yield an empty list in case of an error
    }

    await Future.delayed(const Duration(seconds: 5)); // Wait before fetching again
  }
}
