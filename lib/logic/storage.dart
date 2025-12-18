import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/foods_data.dart';
import '../data/daily_intake.dart';

class StorageService {
  static const String dailyKey = 'daily_intake';
  static const String historyKey = 'daily_history';
  static const String customFoodsKey = 'custom_foods';

  // Save current day
  static Future<void> saveDailyIntake() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> data = dailyIntake.foodsConsumed
        .map((f) => f.toMap())
        .toList();
    await prefs.setString(dailyKey, jsonEncode(data));
  }

  // Load current day
  static Future<void> loadDailyIntake() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load current day
    String? dayData = prefs.getString(dailyKey);
    if (dayData != null) {
      List<dynamic> list = jsonDecode(dayData);
      dailyIntake.foodsConsumed = list.map((item) => FoodItem.fromMap(item)).toList();
    }

    // Load history
    String? historyData = prefs.getString(historyKey);
    if (historyData != null) {
      dailyIntake.dailyHistory = List<Map<String, dynamic>>.from(jsonDecode(historyData));
    }

    // Load custom foods
    String? customData = prefs.getString(customFoodsKey);
    if (customData != null) {
      List<dynamic> list = jsonDecode(customData);
      customFoods = list.map((item) => FoodItem.fromMap(item)).toList();
    }
  }

  // Save history
  static Future<void> saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(historyKey, jsonEncode(dailyIntake.dailyHistory));
  }

  // Save custom foods
  static Future<void> saveCustomFoods() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> data = customFoods.map((f) => f.toMap()).toList();
    await prefs.setString(customFoodsKey, jsonEncode(data));
  }
}
