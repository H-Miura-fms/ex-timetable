import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final fileServiceProvider = Provider((ref) => FileService());

class FileService {
  Future<Map<String, dynamic>> loadJson() async {
    final jsonString = await rootBundle.loadString('assets/time_table.json');
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }
}
