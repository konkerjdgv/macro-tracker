import '../logic/user_goals.dart';
import 'foods_data.dart';

enum AvatarState { normal, muscular, chubby }

class DailyIntake {
  // Singleton instance
  static final DailyIntake _instance = DailyIntake._internal();
  factory DailyIntake() => _instance;
  DailyIntake._internal();

  List<FoodItem> foodsConsumed = [];

  // Add food to the list
  void addFood(FoodItem food) {
    foodsConsumed.add(food);
  }

  // Clear daily intake
  void clear() {
    foodsConsumed.clear();
  }

  // Get totals
  int get totalCalories => foodsConsumed.fold(0, (sum, item) => sum + item.calories);
  int get totalProtein => foodsConsumed.fold(0, (sum, item) => sum + item.protein);
  int get totalCarbs => foodsConsumed.fold(0, (sum, item) => sum + item.carbs);
  int get totalFats => foodsConsumed.fold(0, (sum, item) => sum + item.fats);

  // Get Targets
  int get goalProtein => UserGoalsService.targetMacros['protein']!;
  int get goalCarbs => UserGoalsService.targetMacros['carbs']!;
  int get goalFats => UserGoalsService.targetMacros['fats']!;

  // Determine Avatar State based on rules
  // Rule: High Protein (> 80% of goal) -> Muscular
  // Rule: High Carbs (> 110% of goal) -> Chubby
  AvatarState get avatarState {
    if (totalCarbs > goalCarbs * 1.1) {
      return AvatarState.chubby;
    }
    if (totalProtein > goalProtein * 0.8) {
      return AvatarState.muscular;
    }
    return AvatarState.normal;
  }
}

final DailyIntake dailyIntake = DailyIntake();
