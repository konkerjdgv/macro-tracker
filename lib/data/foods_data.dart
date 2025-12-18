import '../screens/add_food_screen.dart';

enum FoodCategory {
  meats,
  vegetables,
  fruits,
  grains,
  dairy,
  fats,
  others;

  String get displayName {
    switch (this) {
      case FoodCategory.meats: return "Carnes";
      case FoodCategory.vegetables: return "Vegetales";
      case FoodCategory.fruits: return "Frutas";
      case FoodCategory.grains: return "Cereales";
      case FoodCategory.dairy: return "Lácteos";
      case FoodCategory.fats: return "Grasas";
      case FoodCategory.others: return "Otros";
      default: return name;
    }
  }
}

class FoodItem {
  final String name;
  final int calories;
  final int protein;
  final int carbs;
  final int fats;
  final FoodCategory category;

  FoodItem({
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'category': category.index,
    };
  }

  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      name: map['name'],
      calories: map['calories'],
      protein: map['protein'],
      carbs: map['carbs'],
      fats: map['fats'],
      category: FoodCategory.values[map['category']],
    );
  }
}

// Global list of custom foods
List<FoodItem> customFoods = [];

// Map of categories to specific foods
final Map<FoodCategory, List<FoodItem>> categorizedFoods = {
  FoodCategory.meats: [
    FoodItem(name: 'Pollo (100g)', calories: 165, protein: 31, carbs: 0, fats: 3, category: FoodCategory.meats),
    FoodItem(name: 'Res (100g)', calories: 250, protein: 26, carbs: 0, fats: 17, category: FoodCategory.meats),
    FoodItem(name: 'Huevos (1)', calories: 78, protein: 6, carbs: 1, fats: 5, category: FoodCategory.meats),
    FoodItem(name: 'Pescado (100g)', calories: 206, protein: 22, carbs: 0, fats: 12, category: FoodCategory.meats),
  ],
  FoodCategory.vegetables: [
    FoodItem(name: 'Brócoli (100g)', calories: 34, protein: 2, carbs: 7, fats: 0, category: FoodCategory.vegetables),
    FoodItem(name: 'Espinaca (100g)', calories: 23, protein: 3, carbs: 4, fats: 0, category: FoodCategory.vegetables),
    FoodItem(name: 'Zanahoria (100g)', calories: 41, protein: 1, carbs: 10, fats: 0, category: FoodCategory.vegetables),
  ],
  FoodCategory.fruits: [
    FoodItem(name: 'Manzana (1)', calories: 52, protein: 0, carbs: 14, fats: 0, category: FoodCategory.fruits),
    FoodItem(name: 'Plátano (1)', calories: 89, protein: 1, carbs: 23, fats: 0, category: FoodCategory.fruits),
  ],
  FoodCategory.grains: [
    FoodItem(name: 'Arroz (100g)', calories: 130, protein: 3, carbs: 28, fats: 0, category: FoodCategory.grains),
    FoodItem(name: 'Pan Integral (1)', calories: 69, protein: 3, carbs: 12, fats: 1, category: FoodCategory.grains),
    FoodItem(name: 'Avena (100g)', calories: 389, protein: 16, carbs: 66, fats: 7, category: FoodCategory.grains),
  ],
  FoodCategory.fats: [
    FoodItem(name: 'Aguacate (100g)', calories: 160, protein: 2, carbs: 9, fats: 15, category: FoodCategory.fats),
    FoodItem(name: 'Aceite de Oliva (1cda)', calories: 119, protein: 0, carbs: 0, fats: 14, category: FoodCategory.fats),
  ],
   FoodCategory.dairy: [
    FoodItem(name: 'Leche (1 vaso)', calories: 150, protein: 8, carbs: 12, fats: 8, category: FoodCategory.dairy),
    FoodItem(name: 'Yogurt Griego (100g)', calories: 59, protein: 10, carbs: 3, fats: 0, category: FoodCategory.dairy),
  ],
  FoodCategory.others: [],
};

// Helper to get all foods including custom ones
List<FoodItem> getFoodsByCategory(FoodCategory category) {
  List<FoodItem> list = List.from(categorizedFoods[category] ?? []);
  list.addAll(customFoods.where((f) => f.category == category));
  return list;
}

