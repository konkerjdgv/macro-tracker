import '../data/daily_intake.dart';

class NutritionCalculations {
  static double proteinPercentage() {
    if (dailyIntake.totalCalories == 0) return 0;
    return (dailyIntake.totalProtein * 4 / dailyIntake.totalCalories) * 100;
  }

  static double carbsPercentage() {
    if (dailyIntake.totalCalories == 0) return 0;
    return (dailyIntake.totalCarbs * 4 / dailyIntake.totalCalories) * 100;
  }

  static double fatsPercentage() {
    if (dailyIntake.totalCalories == 0) return 0;
    return (dailyIntake.totalFats * 9 / dailyIntake.totalCalories) * 100;
  }
}
