import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadStringAsMap(String key) async {
  final rootBundleString = await rootBundle.loadString(key);
  return jsonDecode(rootBundleString);
}
