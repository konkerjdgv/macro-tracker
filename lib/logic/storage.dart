import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/foods_data.dart';
import '../data/daily_intake.dart';

class StorageService {
  static const String dailyKey = 'daily_intake';

  // Guardar alimentos del día
  // Guardar alimentos del día
  static Future<void> saveDailyIntake() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> data = dailyIntake.foodsConsumed
        .map((f) => {
              'name': f.name,
              'calories': f.calories,
              'protein': f.protein,
              'carbs': f.carbs,
              'fats': f.fats,
              'category': f.category.index, // Save enum index
            })
        .toList();
    await prefs.setString(dailyKey, jsonEncode(data));
  }

  // Cargar alimentos del día
  static Future<void> loadDailyIntake() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(dailyKey);
    if (data != null) {
      List<dynamic> list = jsonDecode(data);
      dailyIntake.foodsConsumed = list
          .map((item) => FoodItem(
                name: item['name'],
                calories: item['calories'],
                protein: item['protein'],
                carbs: item['carbs'],
                fats: item['fats'],
                category: item['category'] != null 
                    ? FoodCategory.values[item['category']] 
                    : FoodCategory.others, // Default if missing
              ))
          .toList();
    }
  }
}
